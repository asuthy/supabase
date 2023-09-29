set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.on_auth_users_update()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
begin
  update copyfuse.members
  set pending = false
  where user_id = new.id
  and pending = true
  and new.last_sign_in_at > old.last_sign_in_at;
  return new;
end;
$function$
;

create or replace trigger on_auth_users_update
after update on auth.users
for each row
execute function on_auth_users_update();
