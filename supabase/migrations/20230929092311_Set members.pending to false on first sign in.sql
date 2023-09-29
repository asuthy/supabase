set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.on_auth_users_update()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
declare
  member_id bigint;
begin
  if new.last_sign_in_at > old.last_sign_in_at then
    update copyfuse.members
    set pending = false
    where user_id = new.id
    and pending = true;

    select id into member_id
    from copyfuse_members
    where user_id = new.id;

    insert into copyfuse.activities(member_id, activity_category, activity_json)
    values (new.id, 'auth.sign_in', ROW_TO_JSON(new));
  end if;

  return new;
end;
$function$
;

create or replace trigger on_auth_users_update
after update on auth.users
for each row
execute function on_auth_users_update();
