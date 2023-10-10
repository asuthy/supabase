create schema if not exists secrets;

grant all on schema secrets to postgres, anon, authenticated, service_role;

ALTER DEFAULT PRIVILEGES REVOKE EXECUTE ON FUNCTIONS FROM PUBLIC;