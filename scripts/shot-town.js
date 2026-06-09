/** Walk out of the house to the town and screenshot at a given resolution. */
const puppeteer = require('puppeteer');
const W = Number(process.argv[2] || 2560), H = Number(process.argv[3] || 1080);
const OUT = process.argv[4] || 'shot-town.png';
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
        await page.type('#new-player-name', 'T' + String(Date.now()).slice(-4));
        await page.click('#player-create-form input[type=submit]');
        await page.waitForFunction(() => document.body.classList.contains('game-engine-started'), { timeout: 60000 });
        await sleep(4000);
        await page.bringToFront();
        // walk down through the house door into town; check the active scene key:
        const key = () => page.evaluate(() => { try { return window.reldens.getActiveScene().key; } catch (e) { return null; } });
        let cur = await key();
        console.log('start scene', cur);
        for (let i = 0; i < 30 && cur === 'reldens-house-1'; i++) {
            await page.keyboard.down('ArrowDown');
            await sleep(450);
            await page.keyboard.up('ArrowDown');
            await sleep(150);
            cur = await key();
        }
        console.log('scene now', cur);
        await sleep(5000);
        await page.screenshot({ path: OUT });
        console.log('Saved', OUT, W + 'x' + H, '| scene', cur);
    } catch (error) {
        console.error('ERR', error.message);
        process.exitCode = 1;
    } finally {
        await browser.close();
    }
})();
