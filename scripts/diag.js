/** Diagnostic: dump HUD button positions + camera/map info after guest login (house-1). */
const puppeteer = require('puppeteer');
const URL = process.env.SHOT_URL || 'http://localhost:8080';
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
    const browser = await puppeteer.launch({
        headless: 'new',
        args: ['--no-sandbox', '--disable-setuid-sandbox', '--use-gl=angle', '--use-angle=swiftshader',
            '--enable-unsafe-swiftshader', '--ignore-gpu-blocklist', '--enable-webgl', '--window-size=1600,900']
    });
    try {
        const page = await browser.newPage();
        await page.setViewport({ width: 1600, height: 900 });
        await page.goto(URL, { waitUntil: 'networkidle2', timeout: 60000 });
        await page.waitForSelector('#guest-form input[type=submit]', { timeout: 20000 });
        await page.click('#guest-form input[type=submit]');
        await page.waitForFunction(() => {
            const s = document.querySelector('#player-selection');
            return s && !s.classList.contains('hidden');
        }, { timeout: 30000 });
        await page.evaluate(() => document.querySelector('#player-create-form')?.classList.remove('hidden'));
        await page.waitForSelector('#new-player-name', { visible: true, timeout: 30000 });
        await page.type('#new-player-name', 'Diag' + String(Date.now()).slice(-4));
        await page.click('#player-create-form input[type=submit]');
        await page.waitForFunction(() => document.body.classList.contains('game-engine-started'), { timeout: 60000 });
        await sleep(6000);
        const data = await page.evaluate(() => {
            const out = { buttons: [], camera: null, canvas: null };
            const canvas = document.querySelector('#reldens canvas');
            if (canvas) {
                const r = canvas.getBoundingClientRect();
                out.canvas = { w: Math.round(r.width), h: Math.round(r.height) };
            }
            document.querySelectorAll('.open-ui-button').forEach((el) => {
                const r = el.getBoundingClientRect();
                out.buttons.push({
                    id: el.id || '(noid)',
                    x: Math.round(r.x), y: Math.round(r.y), w: Math.round(r.width), h: Math.round(r.height)
                });
            });
            try {
                const rd = window.reldens;
                const scene = rd.getActiveScene && rd.getActiveScene();
                if (scene && scene.cameras) {
                    const c = scene.cameras.main;
                    out.camera = {
                        zoom: c.zoom, width: c.width, height: c.height,
                        scrollX: Math.round(c.scrollX), scrollY: Math.round(c.scrollY),
                        mapW: scene.map ? (scene.map.widthInPixels || scene.map.width * scene.map.tileWidth) : null,
                        mapH: scene.map ? (scene.map.heightInPixels || scene.map.height * scene.map.tileHeight) : null,
                        sceneKey: scene.key
                    };
                }
            } catch (e) { out.cameraError = e.message; }
            return out;
        });
        console.log(JSON.stringify(data, null, 2));
    } catch (error) {
        console.error('DIAG_ERROR', error.message);
        process.exitCode = 1;
    } finally {
        await browser.close();
    }
})();
