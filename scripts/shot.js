/**
 * Headless screenshot harness for Relding.
 * Logs in as guest, creates a character, and captures the game canvas at 16:9.
 * Usage: node scripts/shot.js [outfile]
 */
const puppeteer = require('puppeteer');

const OUT = process.argv[2] || 'shot.png';
const URL = process.env.SHOT_URL || 'http://localhost:8080';

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

(async () => {
    const browser = await puppeteer.launch({
        headless: 'new',
        args: [
            '--no-sandbox',
            '--disable-setuid-sandbox',
            '--use-gl=angle',
            '--use-angle=swiftshader',
            '--enable-unsafe-swiftshader',
            '--ignore-gpu-blocklist',
            '--enable-webgl',
            '--window-size=1600,900'
        ]
    });
    try {
        const page = await browser.newPage();
        await page.setViewport({ width: 1600, height: 900 });
        page.on('console', (m) => {
            const t = m.text();
            if (/error|fail|exception/i.test(t)) {
                console.log('PAGE:', t);
            }
        });
        console.log('Opening', URL);
        await page.goto(URL, { waitUntil: 'networkidle2', timeout: 60000 });

        // sign in as guest:
        await page.waitForSelector('#guest-form input[type=submit]', { timeout: 20000 });
        await page.click('#guest-form input[type=submit]');
        console.log('Guest submitted');

        // character creation:
        await page.waitForSelector('#player-selection', { timeout: 30000 });
        await page.waitForFunction(
            () => {
                const sel = document.querySelector('#player-selection');
                return sel && !sel.classList.contains('hidden');
            },
            { timeout: 30000 }
        );
        await page.evaluate(() => {
            document.querySelector('#player-create-form')?.classList.remove('hidden');
        });
        await page.waitForSelector('#new-player-name', { visible: true, timeout: 30000 });
        await page.type('#new-player-name', 'Tester' + String(Date.now()).slice(-4));
        await page.click('#player-create-form input[type=submit]');
        console.log('Character submitted');

        // wait for the game to start:
        await page.waitForFunction(
            () => document.body.classList.contains('game-engine-started'),
            { timeout: 60000 }
        );
        console.log('Game started, rendering...');
        await sleep(7000);

        await page.screenshot({ path: OUT });
        console.log('Saved', OUT);
    } catch (error) {
        console.error('SHOT_ERROR', error.message);
        try {
            const pages = await browser.pages();
            if (pages[0]) {
                await pages[0].screenshot({ path: 'shot-error.png' });
                console.log('Saved shot-error.png');
            }
        } catch (e) {}
        process.exitCode = 1;
    } finally {
        await browser.close();
    }
})();
