create schema if not exists swiss;

GRANT USAGE ON SCHEMA swiss TO anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA swiss TO anon, authenticated, service_role;
GRANT ALL ON ALL ROUTINES IN SCHEMA swiss TO anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA swiss TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA swiss GRANT ALL ON TABLES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA swiss GRANT ALL ON ROUTINES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA swiss GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;
