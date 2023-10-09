create schema if not exists swiss;

grant all on schema swiss to postgres, anon, authenticated, service_role;

ALTER DEFAULT PRIVILEGES REVOKE EXECUTE ON FUNCTIONS FROM PUBLIC;
