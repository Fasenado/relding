# Deploying Relding to Railway

This guide takes the local project online so other players can connect over the internet.
Relding is a persistent Node.js server (Colyseus multiplayer) + MySQL, so it runs as a
long-lived service with a database — Railway fits this well.

The repo already includes everything needed:

- `railway-start.js` — boot wrapper that maps Railway's `PORT`, public domain and MySQL
  plugin variables to the `RELDENS_*` variables the engine expects.
- `railway.json` / `nixpacks.toml` — build + start configuration (`node railway-start.js`).
- `deploy/reldens-db.sql` — a full export of the working local database (maps, rooms, items,
  NPCs, etc.). Railway's MySQL starts empty, so you import this once.

---

## 1. Push the project to GitHub

From the project folder:

```bash
git init
git add .
git commit -m "Relding deploy"
git branch -M main
git remote add origin https://github.com/<you>/relding.git
git push -u origin main
```

`.env` is git-ignored on purpose (it holds local secrets). On Railway you set variables in
the dashboard instead (step 4).

## 2. Create the Railway project + MySQL

1. Go to https://railway.app → **New Project** → **Deploy from GitHub repo** → pick the repo.
2. In the same project: **New** → **Database** → **Add MySQL**.

Railway auto-provides these to your service: `MYSQLHOST`, `MYSQLPORT`, `MYSQLUSER`,
`MYSQLPASSWORD`, `MYSQLDATABASE` (usually `railway`), plus `MYSQL_URL`. `railway-start.js`
reads them automatically — you do **not** need to set the DB variables by hand.

## 3. Import the database

The MySQL plugin → **Variables** tab shows a public connection (host/port/user/password).
Using a local MySQL client, import the dump into the `railway` database:

```bash
mysql -h <PUBLIC_HOST> -P <PUBLIC_PORT> -u root -p<PASSWORD> railway < deploy/reldens-db.sql
```

(Or use `railway connect MySQL` with the Railway CLI, then `source deploy/reldens-db.sql`.)

This loads the fully-installed schema + content, so the engine skips first-run install.

## 4. Set service variables

On the **app service** → **Variables**, add:

| Variable | Value |
| --- | --- |
| `RELDENS_STORAGE_DRIVER` | `objection-js` |
| `RELDENS_DB_CLIENT` | `mysql2` |
| `RELDENS_DEFAULT_ENCODING` | `utf8` |
| `RELDENS_ADMIN_ROUTE_PATH` | `/reldens-admin` |
| `RELDENS_ADMIN_SECRET` | a long random secret |
| `RELDENS_HOT_PLUG` | `0` |
| `RELDENS_LOG_LEVEL` | `5` |
| `RELDENS_FIREBASE_ENABLE` | `0` |
| `RELDENS_MAILER_ENABLE` | `0` |
| `RELDENS_ALLOW_RUN_BUNDLER` | `1` |

Do **not** set `PORT`, `RELDENS_APP_PORT`, `RELDENS_PUBLIC_URL` or the `RELDENS_DB_*`
host/credentials — those are derived automatically from Railway at boot.

## 5. Generate the domain + deploy

1. App service → **Settings** → **Networking** → **Generate Domain**.
2. Redeploy. On boot you should see:
   `[railway-start] Booting Relding on port ... | public: https://<your>.up.railway.app`
3. Open the domain. The first load triggers a client bundle (can take a minute).

## 6. Create an admin user (optional)

Admins manage maps/items/NPCs at `https://<domain>/reldens-admin`. Create one via the
Railway CLI:

```bash
railway run node node_modules/reldens/bin/reldens-commands.js createAdmin
```

---

## Notes & troubleshooting

- **WebSockets**: Railway proxies `wss://` automatically; the client connects to the public
  domain derived in `railway-start.js`. No extra config needed.
- **Empty world / errors about missing tables**: the DB import (step 3) didn't run against
  the `railway` database. Re-run it and confirm the tables exist.
- **Wallet login**: Phantom login is fully client-side (public key = username, signature =
  password), so it works identically once deployed over HTTPS.
- **Persistence**: player data lives in MySQL (managed by Railway). The app container's
  filesystem is ephemeral — that's fine, all content/state is in the database.
- **Updating content**: edit via the admin panel in production, or re-export and re-import
  the DB if you change content locally.
