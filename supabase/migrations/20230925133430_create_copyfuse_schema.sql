create schema if not exists copyfuse;

GRANT USAGE ON SCHEMA copyfuse TO anon, authenticated, service_role;
GRANT ALL ON ALL TABLES IN SCHEMA copyfuse TO anon, authenticated, service_role;
GRANT ALL ON ALL ROUTINES IN SCHEMA copyfuse TO anon, authenticated, service_role;
GRANT ALL ON ALL SEQUENCES IN SCHEMA copyfuse TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA copyfuse GRANT ALL ON TABLES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA copyfuse GRANT ALL ON ROUTINES TO anon, authenticated, service_role;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA copyfuse GRANT ALL ON SEQUENCES TO anon, authenticated, service_role;
