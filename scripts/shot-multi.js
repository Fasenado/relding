/**
 * Multiplayer smoke test: logs in two guests into the same scene and screenshots player one.
 * If online sync works, player one should see player two's avatar in the room.
 */
const puppeteer = require('puppeteer');

const URL = process.env.SHOT_URL || 'http://localhost:8080';
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

async function joinGuest(browser, name) {
    const page = await browser.newPage();
    await page.setViewport({ width: 1600, height: 900 });
    await page.goto(URL, { waitUntil: 'networkidle2', timeout: 60000 });
    await page.waitForSelector('#guest-form input[type=submit]', { timeout: 20000 });
    await page.click('#guest-form input[type=submit]');
    await page.waitForFunction(
        () => {
            const sel = document.querySelector('#player-selection');
            return sel && !sel.classList.contains('hidden');
        },
        { timeout: 30000 }
    );
    await page.evaluate(() => document.querySelector('#player-create-form')?.classList.remove('hidden'));
    await page.waitForSelector('#new-player-name', { visible: true, timeout: 30000 });
    await page.type('#new-player-name', name);
    await page.click('#player-create-form input[type=submit]');
    await page.waitForFunction(() => document.body.classList.contains('game-engine-started'), { timeout: 60000 });
    return page;
}

(async () => {
    const browser = await puppeteer.launch({
        headless: 'new',
        args: ['--no-sandbox', '--disable-setuid-sandbox', '--use-gl=angle', '--use-angle=swiftshader',
            '--enable-unsafe-swiftshader', '--ignore-gpu-blocklist', '--enable-webgl', '--window-size=1600,900']
    });
    try {
        const p1 = await joinGuest(browser, 'Alpha' + String(Date.now()).slice(-4));
        console.log('Player one in game');
        const p2 = await joinGuest(browser, 'Bravo' + String(Date.now()).slice(-4));
        console.log('Player two in game');
        await sleep(7000);
        await p1.bringToFront();
        await p1.screenshot({ path: 'shot-multi.png' });
        console.log('Saved shot-multi.png');
    } catch (error) {
        console.error('MULTI_ERROR', error.message);
        process.exitCode = 1;
    } finally {
        await browser.close();
    }
})();
