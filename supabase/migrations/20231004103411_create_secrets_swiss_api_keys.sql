DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pgsodium.key) THEN
    PERFORM pgsodium.create_key();
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS secrets.swiss_tokens (
    id bigserial primary key,
    token text,
    networks bigint not null,
    collections bigint not null,
    key_id uuid NOT NULL,
    nonce bytea DEFAULT pgsodium.crypto_aead_det_noncegen()
  );

alter table "secrets"."swiss_tokens" alter column "nonce" set not null;

alter table "secrets"."swiss_tokens" enable row level security;

alter table "secrets"."swiss_tokens" add constraint "swiss_tokens_collections_fkey" FOREIGN KEY (collections) REFERENCES swiss.collections(id) ON DELETE SET NULL not valid;

alter table "secrets"."swiss_tokens" validate constraint "swiss_tokens_collections_fkey";

alter table "secrets"."swiss_tokens" add constraint "swiss_tokens_networks_fkey" FOREIGN KEY (networks) REFERENCES copyfuse.networks(id) ON DELETE SET NULL not valid;

alter table "secrets"."swiss_tokens" validate constraint "swiss_tokens_networks_fkey";

DO $$
BEGIN
EXECUTE format('ALTER TABLE secrets.swiss_tokens ALTER COLUMN key_id SET DEFAULT %L'
             , (SELECT a.id::uuid FROM pgsodium.key a));
END $$;

SECURITY LABEL FOR pgsodium
  ON COLUMN secrets.swiss_tokens.token
    IS 'ENCRYPT WITH KEY COLUMN key_id ASSOCIATED (collections) NONCE nonce';

grant all on table secrets.swiss_tokens to authenticated, service_role;
GRANT ALL ON sequence secrets.swiss_tokens_id_seq TO authenticated, service_role;