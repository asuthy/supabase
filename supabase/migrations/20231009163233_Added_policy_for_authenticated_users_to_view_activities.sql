create policy "Authenticated users can view activities"
on "copyfuse"."activities"
as permissive
for select
to authenticated
using (true);
