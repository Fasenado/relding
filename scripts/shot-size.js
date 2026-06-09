/** Screenshot at an arbitrary resolution. Usage: node scripts/shot-size.js <w> <h> <out> */
const puppeteer = require('puppeteer');
const W = Number(process.argv[2] || 2560), H = Number(process.argv[3] || 1080);
const OUT = process.argv[4] || 'shot-size.png';
const URL = process.env.SHOT_URL || 'http://localhost:8080';
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
    const browser = await puppeteer.launch({
        headless: 'new',
        args: ['--no-sandbox', '--disable-setuid-sandbox', '--use-gl=angle', '--use-angle=swiftshader',
            '--enable-unsafe-swiftshader', '--ignore-gpu-blocklist', '--enable-webgl', `--window-size=${W},${H}`]
    });
    try {
        const page = await browser.newPage();
        await page.setViewport({ width: W, height: H });
        await page.goto(URL, { waitUntil: 'networkidle2', timeout: 60000 });
        await page.waitForSelector('#guest-form input[type=submit]', { timeout: 20000 });
        await page.click('#guest-form input[type=submit]');
        await page.waitForFunction(() => {
            const s = document.querySelector('#player-selection');
            return s && !s.classList.contains('hidden');
        }, { timeout: 30000 });
        await page.evaluate(() => document.querySelector('#player-create-form')?.classList.remove('hidden'));
        await page.waitForSelector('#new-player-name', { visible: true, timeout: 30000 });
        await page.type('#new-player-name', 'S' + String(Date.now()).slice(-4));
        await page.click('#player-create-form input[type=submit]');
        await page.waitForFunction(() => document.body.classList.contains('game-engine-started'), { timeout: 60000 });
        await sleep(7000);
        await page.screenshot({ path: OUT });
        console.log('Saved', OUT, W + 'x' + H);
    } catch (error) {
        console.error('ERR', error.message);
        process.exitCode = 1;
    } finally {
        await browser.close();
    }
})();
