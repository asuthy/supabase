insert into vault.secrets (secret, name, description)
select id::uuid, 'jwt_secret', 'Secret used to sign jwts'
from  pgsodium.key
returning *;

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION copyfuse.get_jwt_secret()
  RETURNS text
  LANGUAGE plpgsql
  SECURITY DEFINER
AS $function$
declare
  jwt_secret text;
begin
  select decrypted_secret into jwt_secret
  from vault.decrypted_secrets
  where name = 'jwt_secret';

  return jwt_secret;
end;
$function$
;

CREATE OR REPLACE FUNCTION swiss.request_api_key(json)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
declare
  networks integer;
  collections integer;
  token text;
  jwt_secret text;
begin
  select $1->>'networks' into networks;
  select $1->>'collections' into collections;

  select * into jwt_secret
  from copyfuse.get_jwt_secret();

  select sign into token from
  extensions.sign(
    payload   := JSON_BUILD_OBJECT('networks', networks, 'collections', collections),
    secret    := jwt_secret,
    algorithm := 'HS256'
  );

  insert into secrets.swiss_tokens
  (token, networks, collections)
  select token, networks, collections;

  return JSON_BUILD_OBJECT('token', token);
end;
$function$
;

CREATE OR REPLACE FUNCTION swiss.verify_api_key(token_param text)
 RETURNS boolean
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
declare 
  verified_payload text;
  payload_networks int;
  payload_collections int;
  jwt_secret text;
begin
  select decrypted_secret into jwt_secret
  from vault.decrypted_secrets
  where name = 'jwt_secret';

  select payload into verified_payload from
  extensions.verify(
    token := token_param,
    secret := jwt_secret,
    algorithm := 'HS256'
  );

  select (verified_payload::json->>'networks')::integer into payload_networks;
  select (verified_payload::json->>'collections')::integer into payload_collections;
  
  if exists( select 1
              from secrets.decrypted_swiss_tokens
              where networks = payload_networks
              and collections = payload_collections
              and decrypted_token = token_param) then
    return true;
  end if;

  return false;
end;
$function$
;

GRANT EXECUTE ON FUNCTION swiss.request_api_key TO authenticated, service_role;
GRANT EXECUTE ON FUNCTION swiss.verify_api_key TO anon, authenticated, service_role;
GRANT EXECUTE ON FUNCTION copyfuse.get_jwt_secret TO authenticated, service_role;

create policy "Allow verified keys to create entities in their collections"
    on "swiss"."entities"
    as permissive
    for insert
    to public
    with check (swiss.verify_api_key((current_setting('request.headers'::text, true))::json ->> 'swiss-apikey'::text ));

create policy "Allow verified keys to view entities in their collections"
    on "swiss"."entities"
    as permissive
    for select
    to public
    using (swiss.verify_api_key((current_setting('request.headers'::text, true))::json ->> 'swiss-apikey'::text ));