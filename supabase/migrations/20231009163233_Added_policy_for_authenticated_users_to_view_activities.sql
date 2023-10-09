create policy "Authenticated users can view activities"
on "copyfuse"."activities"
as permissive
for select
to authenticated
using (true);



alter table "kis"."swiss_api_keys" alter column "key_id" set default '7cfba1f9-8551-498c-a63d-8d8864632e58'::uuid;


