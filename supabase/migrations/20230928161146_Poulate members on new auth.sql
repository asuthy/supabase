set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.on_auth_users_insert()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
begin
  insert into copyfuse.members(email, user_id)
  values (new.email, new.id);
  return new;
end;
$function$
;


