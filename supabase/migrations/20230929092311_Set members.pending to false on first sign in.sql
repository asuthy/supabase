set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.on_auth_users_update()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
declare
  member_id bigint;
begin
  if (new.last_sign_in_at <> old.last_sign_in_at) or (new.last_sign_in_at is not null and old.last_sign_in_at is null) then
    update copyfuse.members
    set pending = false
    where user_id = new.id
    and pending = true;

    select id into member_id
    from copyfuse.members
    where user_id = new.id;

    insert into copyfuse.activities(members, activity_category, activity_json)
    values (member_id, 'auth.sign_in', ROW_TO_JSON(new));
  end if;

  return new;
end;
$function$
;

create or replace trigger on_auth_users_update
after update on auth.users
for each row
execute function on_auth_users_update();
