create table "copyfuse"."networks_members" (
    "id" bigint generated by default as identity not null,
    "created_at" timestamp with time zone not null default now(),
    "networks" bigint,
    "members" bigint
);


alter table "copyfuse"."networks_members" enable row level security;

CREATE UNIQUE INDEX networks_members_pkey ON copyfuse.networks_members USING btree (id);

alter table "copyfuse"."networks_members" add constraint "networks_members_pkey" PRIMARY KEY using index "networks_members_pkey";

alter table "copyfuse"."networks_members" add constraint "networks_members_members_fkey" FOREIGN KEY (members) REFERENCES copyfuse.members(id) ON DELETE SET NULL not valid;

alter table "copyfuse"."networks_members" validate constraint "networks_members_members_fkey";

alter table "copyfuse"."networks_members" add constraint "networks_members_networks_fkey" FOREIGN KEY (networks) REFERENCES copyfuse.networks(id) ON DELETE SET NULL not valid;

alter table "copyfuse"."networks_members" validate constraint "networks_members_networks_fkey";

grant all on table copyfuse.networks_members to authenticated, service_role;