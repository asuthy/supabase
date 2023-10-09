grant execute on all functions in schema pgsodium to authenticated;

create policy "Members can create api keys for networks they are associated to"
    on "kis"."swiss_api_keys"
    as permissive
    for insert
    to authenticated
    with check (networks IN ( SELECT copyfuse.networks_members.networks
    FROM copyfuse.networks_members,
    copyfuse.members
    where copyfuse.networks_members.members = copyfuse.members.id
    and copyfuse.members.user_id = auth.uid()
    and copyfuse.networks_members.networks is not null));