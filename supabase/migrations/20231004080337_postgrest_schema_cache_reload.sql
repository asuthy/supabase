-- This needs to be called to update postgREST after schema changes.
-- Automatic cache reloading explained here currently isn't possible with supabase as it doesn't allow superuser access https://postgrest.org/en/stable/references/schema_cache.html#schema-reloading

NOTIFY pgrst, 'reload schema';