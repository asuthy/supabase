create policy "Members can create collections for networks they are associated to"
    on "swiss"."collections"
    as permissive
    for insert
    to public
    with check (networks IN ( SELECT copyfuse.networks_members.networks
    FROM copyfuse.networks_members,
    copyfuse.members
    where copyfuse.networks_members.members = copyfuse.members.id
    and copyfuse.members.user_id = auth.uid()
    and copyfuse.networks_members.networks is not null));

create policy "Members can view collections for networks they are associated to"
    on "swiss"."collections"
    as permissive
    for select
    to public
    using (networks IN ( SELECT copyfuse.networks_members.networks
    FROM copyfuse.networks_members,
    copyfuse.members
    where copyfuse.networks_members.members = copyfuse.members.id
    and copyfuse.members.user_id = auth.uid()
    and copyfuse.networks_members.networks is not null));

create policy "Allow all users to create entities"
    on "swiss"."entities"
    as permissive
    for insert
    to public
    with check (true);

create policy "Entities are temporarily viewable by everyone"
    on "swiss"."entities"
    as permissive
    for select
    to public
    using (true);