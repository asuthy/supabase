create schema if not exists copyfuse;

grant all on schema copyfuse to postgres, anon, authenticated, service_role;

ALTER DEFAULT PRIVILEGES REVOKE EXECUTE ON FUNCTIONS FROM PUBLIC;