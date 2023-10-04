create policy "Allow all users to create collections"
    on "swiss"."collections"
    as permissive
    for insert
    to public
    with check (true);

create policy "Collections are temporarily viewable by everyone."
    on "swiss"."collections"
    as permissive
    for select
    to public
    using (true);

create policy "Allow all users to create entities"
    on "swiss"."entities"
    as permissive
    for insert
    to public
    with check (true);

create policy "Entities are temporarily viewable by everyone."
    on "swiss"."entities"
    as permissive
    for select
    to public
    using (true);