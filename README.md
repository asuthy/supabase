## Development

To get started with development first clone the repo and start up the
devcontainer.

Start Supabase with:

```bash
supabase start
```

Stop Supabase and persist data with:

```bash
supabase stop
```

Stop Supabase and remove data with:

```bash
supabase stop --no-backup
```

To serve supabase edge functions locally run:

```bash
supabase functions serve
```

#### Exposed Endpoints

```bash
api: http://localhost:54321
db: postgresql://postgres:postgres@localhost:54322/postgres
studio: http://localhost:54323
inbucket: http://localhost:54324
```

## Local Development (Mac with docker installed)

#### Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### Install Supabase

```bash
arch -arm64 brew install supabase
```

#### Install Deno

```bash
arch -arm64 brew install deno

Install Deno VSCode extension
Set "Deno: Path" in extension User settings to /opt/homebrew/bin/deno
```

#### Start Supabase

```bash
supabase start
supabase functions serve
```

## Secrets

#### Slack token and channel to use to send notifications

```
insert into vault.secrets (secret, name, description)
values ('token', 'slack_notification_token', 'Slack token to enable notifications') returning *;

insert into vault.secrets (secret, name, description)
values ('channel', 'slack_notification_channel', 'Slack channel to send notification to') returning *;
```

## Swiss

#### Auth

Pass anon key as bearer token

#### Headers

```
GET,HEAD - Accept-Profile swiss
POST,PATCH,PUT,DELETE - Content-Profile swiss | Prefer return=representation
```

#### Get swiss collections locally

```
GET - http://localhost:54321/rest/v1/collections

Returns status 200 with array of collections
```

#### Get swiss collections and their entities locally

```
GET - http://localhost:54321/rest/v1/collections?select=id,name,description,entities(*)&order=id
HEADER - swiss-apikey = ?

Returns status 200 with array of collections with their associated entities
```

#### Create swiss collections locally (need to be a member of the network)

```
POST - http://localhost:54321/rest/v1/collections?select=*

BODY

{
    "networks": "1",
    "name": "Test",
    "description": "Test"
}

Returns status 201 - created with an array of created collections
```

#### Get swiss entities locally

```
GET - http://localhost:54321/rest/v1/entities
HEADER - swiss-apikey = ?

Returns status 200 with array of entities
```

#### Create swiss entities locally

```
POST - http://localhost:54321/rest/v1/entities?select=*
HEADER - swiss-apikey = ?

BODY

{
    "collections": "1",
    "entities_json":
    {
        "key1": "val1",
        "key2": "val2"
    }
}

Returns status 201 - created with an array of created entities
```

#### Request swiss api key locally

```
POST - http://localhost:54321/rest/v1/rpc/request_api_key

BODY

{
    "networks": 1,
    "collections": 1
}

Returns status 200 - json containing token string
```
