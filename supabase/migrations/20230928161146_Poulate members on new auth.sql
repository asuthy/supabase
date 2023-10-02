set check_function_bodies = off;

CREATE OR REPLACE FUNCTION copyfuse.on_auth_users_insert()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
declare
  member_id bigint;
begin
  insert into copyfuse.members(email, user_id)
  values (new.email, new.id)
  returning id into member_id;
  
  insert into copyfuse.activities(members, activity_category, activity_json)
  values (member_id, 'auth.create', JSONB_BUILD_OBJECT('user_id', new.id));

  return new;
end;
$function$
;


