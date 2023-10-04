create extension if not exists "pg_cron" with schema "public" version '1.4-1';

select
  cron.schedule(
    'swiss_ttl_data_removal',
    '*/10 * * * *',
    $$
    select swiss.ttl_data_removal();
    $$
  );