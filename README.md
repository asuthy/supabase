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

### Edge Functions

#### send-otp-email (send sign in code and link to supplied email address via inbucket)

```bash
POST: http://localhost:54321/functions/v1/send-otp-email

data: {"email_address": "email@address.co.uk"}
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
