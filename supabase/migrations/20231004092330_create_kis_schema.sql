create schema if not exists kis;

grant all on schema kis to postgres, anon, authenticated, service_role;

ALTER DEFAULT PRIVILEGES REVOKE EXECUTE ON FUNCTIONS FROM PUBLIC;