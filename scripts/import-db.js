/**
 * Import a SQL dump into a (Railway) MySQL over its TCP proxy, reliably.
 *
 * Splits the dump into individual statements and runs them sequentially on one
 * connection, reconnecting automatically if the proxy drops the link. Idempotent
 * because the dump uses DROP TABLE IF EXISTS before each CREATE.
 *
 * Env: DB_HOST, DB_PORT, DB_USER, DB_PASS, DB_NAME, DUMP_FILE
 * Usage: node scripts/import-db.js
 */
const fs = require('fs');
const mysql = require('mysql2/promise');

const cfg = {
    host: process.env.DB_HOST,
    port: Number(process.env.DB_PORT || 3306),
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASS,
    database: process.env.DB_NAME || 'railway',
    multipleStatements: false,
    connectTimeout: 60000
};
const dumpFile = process.env.DUMP_FILE || 'deploy/reldens-db.sql';

// naive-but-safe split: the Reldens dump has no procedures/`;` inside string
// literals that would break a line-aware split, so we split on ";\n".
function splitStatements(sql)
{
    let cleaned = sql
        .split(/\r?\n/)
        .filter((line) => !line.startsWith('--'))
        .join('\n');
    return cleaned
        .split(/;\s*\n/)
        .map((s) => s.trim())
        .filter((s) => s.length > 0);
}

async function connect()
{
    let conn = await mysql.createConnection(cfg);
    await conn.query('SET FOREIGN_KEY_CHECKS=0');
    await conn.query('SET UNIQUE_CHECKS=0');
    await conn.query("SET NAMES utf8mb4");
    return conn;
}

(async () => {
    let sql = fs.readFileSync(dumpFile, 'utf8');
    let statements = splitStatements(sql);
    console.log('Statements:', statements.length, '| target:', cfg.host + ':' + cfg.port + '/' + cfg.database);
    let conn = await connect();
    let done = 0;
    for(let i = 0; i < statements.length; i++){
        let stmt = statements[i];
        let attempts = 0;
        while(true){
            try {
                await conn.query(stmt);
                done++;
                break;
            } catch (error) {
                if(('PROTOCOL_CONNECTION_LOST' === error.code || 'ECONNRESET' === error.code
                    || 'EPIPE' === error.code || 'ETIMEDOUT' === error.code) && attempts < 5){
                    attempts++;
                    console.log('  reconnecting (stmt ' + i + ', attempt ' + attempts + ')...');
                    try { await conn.end(); } catch (e) {}
                    await new Promise((r) => setTimeout(r, 1500));
                    conn = await connect();
                    continue;
                }
                console.error('FAILED at statement', i, '->', error.code, error.message);
                console.error(stmt.slice(0, 160));
                process.exit(1);
            }
        }
        if(0 === done % 25){
            console.log('  applied', done, '/', statements.length);
        }
    }
    let [rows] = await conn.query(
        "SELECT COUNT(*) AS c FROM information_schema.tables WHERE table_schema=?", [cfg.database]);
    console.log('Done. Applied', done, 'statements. Tables now:', rows[0].c);
    await conn.end();
})().catch((error) => { console.error('IMPORT_ERROR', error.code, error.message); process.exit(1); });
