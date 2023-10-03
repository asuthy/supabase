set check_function_bodies = off;

CREATE OR REPLACE FUNCTION copyfuse.on_auth_mfa_amr_claims_insert()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
declare
  member_id bigint;
  sign_in_user_id uuid;
begin
  select user_id into sign_in_user_id
  from sessions
  where id = new.session_id;

  select id into member_id
  from copyfuse.members
  where user_id = sign_in_user_id;

  update copyfuse.members
  set pending = false
  where user_id = sign_in_user_id
  and pending = true;

  insert into copyfuse.activities(members, activity_category, activity_json)
  values (member_id, 'auth.sign_in', JSONB_BUILD_OBJECT('user_id', sign_in_user_id));

  return new;
end;
$function$
;

create or replace trigger on_mfa_amr_claims_insert
after insert on auth.mfa_amr_claims
for each row
execute function copyfuse.on_auth_mfa_amr_claims_insert();
