CREATE OR REPLACE FUNCTION copyfuse.is_users_networks_members(networks_param bigint, user_id_param uuid)
 RETURNS boolean
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
begin  
  if exists(  SELECT copyfuse.networks_members.networks
              FROM copyfuse.networks_members,
              copyfuse.members
              where copyfuse.networks_members.members = copyfuse.members.id
              and copyfuse.members.user_id = user_id_param
              and copyfuse.networks_members.networks = networks_param
              and copyfuse.networks_members.networks is not null) then
    return true;
  end if;

  return false;
end;
$function$
;

GRANT EXECUTE ON FUNCTION copyfuse.is_users_networks_members TO authenticated;
GRANT EXECUTE ON FUNCTION copyfuse.is_users_networks_members TO service_role;

create policy "Members can create collections for networks they are associated to"
    on "swiss"."collections"
    as permissive
    for insert
    to public
    with check (copyfuse.is_users_networks_members(networks, auth.uid()));
        
create policy "Members can view collections for networks they are associated to"
    on "swiss"."collections"
    as permissive
    for select
    to public
    using (copyfuse.is_users_networks_members(networks, auth.uid()));