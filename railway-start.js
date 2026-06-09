/**
 *
 * Relding - Railway boot wrapper
 *
 * Maps the platform-provided environment variables (PORT, Railway domain, MySQL plugin vars)
 * to the RELDENS_* variables the engine expects, then boots the normal server (index.js).
 *
 * This lets you deploy without editing index.js: set the MySQL plugin on Railway and this
 * wrapper wires everything together at runtime.
 *
 */

function setEnv(key, value, { override = false } = {})
{
    if(value === undefined || value === null || value === ''){
        return;
    }
    if(!override && process.env[key]){
        return;
    }
    process.env[key] = String(value);
}

// 1) Port: Railway injects PORT, the engine listens on RELDENS_APP_PORT.
if(process.env.PORT){
    setEnv('RELDENS_APP_PORT', process.env.PORT, { override: true });
}

// 2) Public URL: Railway assigns an https domain. The client (Colyseus over wss) needs it.
let publicDomain = process.env.RAILWAY_PUBLIC_DOMAIN || process.env.RAILWAY_STATIC_URL || '';
publicDomain = publicDomain.replace(/^https?:\/\//, '').replace(/\/$/, '');
if(publicDomain){
    setEnv('RELDENS_PUBLIC_URL', 'https://' + publicDomain, { override: true });
    setEnv('RELDENS_APP_HOST', 'https://' + publicDomain, { override: true });
}

// 3) Database: prefer the Railway MySQL plugin variables, then any explicitly provided ones.
setEnv('RELDENS_DB_CLIENT', 'mysql2');
setEnv('RELDENS_DB_HOST', process.env.MYSQLHOST || process.env.MYSQL_HOST);
setEnv('RELDENS_DB_PORT', process.env.MYSQLPORT || process.env.MYSQL_PORT);
setEnv('RELDENS_DB_NAME', process.env.MYSQLDATABASE || process.env.MYSQL_DATABASE);
setEnv('RELDENS_DB_USER', process.env.MYSQLUSER || process.env.MYSQL_USER);
setEnv('RELDENS_DB_PASSWORD', process.env.MYSQLPASSWORD || process.env.MYSQL_PASSWORD);
if(process.env.MYSQL_URL){
    setEnv('RELDENS_DB_URL', process.env.MYSQL_URL);
}

// 4) Sensible production defaults (only if not already provided).
setEnv('RELDENS_ALLOW_RUN_BUNDLER', '1');
setEnv('RELDENS_EXPRESS_SERVE_STATICS', '1');
setEnv('RELDENS_EXPRESS_SERVE_HOME', '1');

console.log('[railway-start] Booting Relding on port', process.env.RELDENS_APP_PORT,
    '| public:', process.env.RELDENS_PUBLIC_URL || '(local)',
    '| db host:', process.env.RELDENS_DB_HOST);

require('./index.js');
