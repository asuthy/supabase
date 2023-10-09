create table "swiss"."attachments" (
    "id" bigint generated by default as identity not null,
    "entities" bigint,
    "filename" text not null,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
);

alter table "swiss"."attachments" enable row level security;

create table "swiss"."collections" (
    "id" bigint generated by default as identity not null,
    "networks" bigint,
    "name" text not null,
    "description" text not null,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now()
);

alter table "swiss"."collections" enable row level security;

create table "swiss"."entities" (
    "id" bigint generated by default as identity not null,
    "collections" bigint,
    "entities_json" jsonb not null,
    "created_at" timestamp with time zone not null default now(),
    "updated_at" timestamp with time zone not null default now(),
    "expires_at" timestamp with time zone not null default now() + INTERVAL '1 days'
);

alter table "swiss"."entities" enable row level security;

CREATE UNIQUE INDEX attachments_pkey ON swiss.attachments USING btree (id);

CREATE UNIQUE INDEX collections_pkey ON swiss.collections USING btree (id);

CREATE UNIQUE INDEX entities_pkey ON swiss.entities USING btree (id);

alter table "swiss"."attachments" add constraint "attachments_pkey" PRIMARY KEY using index "attachments_pkey";

alter table "swiss"."collections" add constraint "collections_pkey" PRIMARY KEY using index "collections_pkey";

alter table "swiss"."entities" add constraint "entities_pkey" PRIMARY KEY using index "entities_pkey";

alter table "swiss"."attachments" add constraint "attachments_entities_fkey" FOREIGN KEY (entities) REFERENCES swiss.entities(id) ON DELETE SET NULL not valid;

alter table "swiss"."attachments" validate constraint "attachments_entities_fkey";

alter table "swiss"."collections" add constraint "collections_networks_fkey" FOREIGN KEY (networks) REFERENCES copyfuse.networks(id) ON DELETE SET NULL not valid;

alter table "swiss"."collections" validate constraint "collections_networks_fkey";

alter table "swiss"."entities" add constraint "entities_collections_fkey" FOREIGN KEY (collections) REFERENCES swiss.collections(id) ON DELETE SET NULL not valid;

alter table "swiss"."entities" validate constraint "entities_collections_fkey";

grant all on table swiss.attachments to authenticated;
grant all on table swiss.collections to authenticated;
grant all on table swiss.entities to anon, authenticated;