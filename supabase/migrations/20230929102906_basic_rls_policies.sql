CREATE POLICY "Members are viewable by everyone."
    ON copyfuse.members
    AS PERMISSIVE
    FOR SELECT
    TO public
    USING (true);

CREATE POLICY "Users can view their own member details"
    ON copyfuse.members
    AS PERMISSIVE
    FOR SELECT
    TO public
    USING ((user_id = auth.uid()));

create policy "Allow all users to create networks"
    on "copyfuse"."networks"
    as permissive
    for insert
    to public
    with check (true);

create policy "Members can view networks they are associated to"
    on "copyfuse"."networks"
    as permissive
    for select
    to public
    using (id IN ( SELECT copyfuse.networks_members.networks
    FROM copyfuse.networks_members,
    copyfuse.members
    where copyfuse.networks_members.members = copyfuse.members.id
    and copyfuse.members.user_id = auth.uid()));

CREATE POLICY "Authenticated users can see network members"
    ON copyfuse.networks_members
    AS PERMISSIVE
    FOR SELECT
    TO public
    USING ((auth.role() = 'authenticated'::text));