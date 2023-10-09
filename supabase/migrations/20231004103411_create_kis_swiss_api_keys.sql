DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pgsodium.key) THEN
    PERFORM pgsodium.create_key();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS kis.swiss_api_keys (
    id bigserial primary key,
    token text,
    networks bigint not null,
    collections bigint not null,
    key_id uuid NOT NULL,
    nonce bytea DEFAULT pgsodium.crypto_aead_det_noncegen()
  );

alter table "kis"."swiss_api_keys" alter column "nonce" set not null;

alter table "kis"."swiss_api_keys" enable row level security;

alter table "kis"."swiss_api_keys" add constraint "swiss_api_keys_collections_fkey" FOREIGN KEY (collections) REFERENCES swiss.collections(id) ON DELETE SET NULL not valid;

alter table "kis"."swiss_api_keys" validate constraint "swiss_api_keys_collections_fkey";

alter table "kis"."swiss_api_keys" add constraint "swiss_api_keys_networks_fkey" FOREIGN KEY (networks) REFERENCES copyfuse.networks(id) ON DELETE SET NULL not valid;

alter table "kis"."swiss_api_keys" validate constraint "swiss_api_keys_networks_fkey";

DO $$
BEGIN
EXECUTE format('ALTER TABLE kis.swiss_api_keys ALTER COLUMN key_id SET DEFAULT %L'
             , (SELECT a.id::uuid FROM pgsodium.key a));
END $$;

SECURITY LABEL FOR pgsodium
  ON COLUMN kis.swiss_api_keys.token
    IS 'ENCRYPT WITH KEY COLUMN key_id ASSOCIATED (collections) NONCE nonce';

grant all on table kis.swiss_api_keys to authenticated;
GRANT ALL ON sequence kis.swiss_api_keys_id_seq TO authenticated;