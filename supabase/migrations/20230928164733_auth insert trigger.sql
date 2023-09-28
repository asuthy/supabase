create or replace trigger on_auth_users_insert
after insert on auth.users
for each row
execute function on_auth_users_insert();