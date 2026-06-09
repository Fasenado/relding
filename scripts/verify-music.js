const puppeteer = require('puppeteer');
const URL = process.env.SHOT_URL || 'http://localhost:8080';
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
(async () => {
    const browser = await puppeteer.launch({
        headless: 'new',
        args: ['--no-sandbox', '--disable-setuid-sandbox', '--autoplay-policy=no-user-gesture-required',
            '--use-gl=angle', '--use-angle=swiftshader', '--enable-unsafe-swiftshader', '--window-size=1600,900']
    });
    try {
        const page = await browser.newPage();
        await page.setViewport({ width: 1600, height: 900 });
        const errors = [];
        page.on('console', (m) => { if (m.type() === 'error') errors.push(m.text()); });
        page.on('pageerror', (e) => errors.push('PAGEERROR ' + e.message));
        await page.goto(URL, { waitUntil: 'networkidle2', timeout: 60000 });
        await sleep(1500);
        // HEAD check the served track:
        const headStatus = await page.evaluate(async () => {
            try { return (await fetch('/media/theme.mp3', { method: 'HEAD' })).status; } catch (e) { return 'ERR ' + e.message; }
        });
        // simulate a user gesture so autoplay is allowed, then let it play:
        await page.mouse.click(800, 450);
        await sleep(2500);
        const info = await page.evaluate(async () => {
            const a = document.getElementById('relding-bg-music');
            if (a) { try { await a.play(); } catch (e) {} }
            return {
                toggle: !!document.getElementById('relding-music-toggle'),
                audio: !!a,
                audioSrc: a?.getAttribute('src') || null,
                duration: a ? Number(a.duration.toFixed(1)) : null,
                readyState: a ? a.readyState : null,
                currentTime: a ? Number(a.currentTime.toFixed(2)) : null,
                paused: a ? a.paused : null
            };
        });
        console.log('HEAD /media/theme.mp3:', headStatus);
        console.log('toggle:', info.toggle, '| audio:', info.audio, '| src:', info.audioSrc);
        console.log('duration:', info.duration, '| readyState:', info.readyState, '| currentTime:', info.currentTime, '| paused:', info.paused);
        console.log('console errors:', errors.length ? errors.slice(0, 8).join(' || ') : 'none');
        await page.screenshot({ path: 'shot-landing.png' });
        console.log('Saved shot-landing.png');
    } catch (error) {
        console.error('VERIFY_ERROR', error.message);
        process.exitCode = 1;
    } finally {
        await browser.close();
    }
})();
