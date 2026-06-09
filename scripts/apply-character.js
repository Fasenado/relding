/**
 * Apply a CC0 (or any) character spritesheet to the Relding avatar classes.
 *
 * The engine expects each class sheet as a 3x4 grid (3 walk frames x 4 directions:
 * down, left, right, up) at 156x284 px (52x71 per frame). This script takes any
 * 3x4-layout PNG and fits it to that grid using nearest-neighbor (keeps pixel art crisp),
 * then installs it into the theme source and the built dist folder.
 *
 * Usage:
 *   node scripts/apply-character.js path/to/hero.png             # apply to all classes
 *   node scripts/apply-character.js path/to/hero.png --only journeyman
 *
 * After running, restart the server so the bundle/assets refresh.
 */
const { Jimp, ResizeStrategy } = require('jimp');
const fs = require('fs');
const path = require('path');

const FRAME_COLS = 3;
const FRAME_ROWS = 4;
const FRAME_W = 52;
const FRAME_H = 71;
const SHEET_W = FRAME_COLS * FRAME_W; // 156
const SHEET_H = FRAME_ROWS * FRAME_H; // 284

const themeDir = path.join(__dirname, '..', 'theme', 'default', 'assets', 'custom', 'sprites');
const distDir = path.join(__dirname, '..', 'dist', 'assets', 'custom', 'sprites');
const classTargets = ['journeyman', 'warrior', 'warlock', 'sorcerer', 'swordsman', 'player-base', 'healer-1'];

(async () => {
    const input = process.argv[2];
    if(!input){
        console.error('Usage: node scripts/apply-character.js <3x4-character.png> [--only <className>]');
        process.exit(1);
    }
    if(!fs.existsSync(input)){
        console.error('Input file not found:', input);
        process.exit(1);
    }
    const onlyIdx = process.argv.indexOf('--only');
    const only = (-1 < onlyIdx) ? process.argv[onlyIdx + 1] : null;

    const image = await Jimp.read(input);
    console.log('Loaded', input, image.bitmap.width + 'x' + image.bitmap.height);
    image.resize({ w: SHEET_W, h: SHEET_H, mode: ResizeStrategy.NEAREST_NEIGHBOR });

    const targets = only ? [only] : classTargets;
    for(const name of targets){
        for(const dir of [themeDir, distDir]){
            if(!fs.existsSync(dir)){
                continue;
            }
            const out = path.join(dir, name + '.png');
            await image.clone().write(out);
            console.log('Wrote', out);
        }
    }
    console.log('Done. Restart the server to rebuild and see the new avatar.');
})().catch((error) => {
    console.error('APPLY_ERROR', error.message);
    process.exit(1);
});
