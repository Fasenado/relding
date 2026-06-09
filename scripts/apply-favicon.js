/**
 * Build the Relding favicons from a single source icon.
 *
 * Auto-crops the white frame around the generated icon, cleans any leftover near-white
 * corners to the dark brand background, then exports every size the site references
 * (HTML <link> tags + site.webmanifest) into theme assets and the built dist folder.
 *
 * Usage: node scripts/apply-favicon.js <source.png>
 */
const { Jimp, ResizeStrategy } = require('jimp');
const fs = require('fs');
const path = require('path');

const BG = 0x0e1320ff; // brand dark background
const sizes = {
    'favicon-16x16.png': 16,
    'favicon-32x32.png': 32,
    'apple-touch-icon.png': 180,
    'android-icon-144x144.png': 144,
    'android-icon-192x192.png': 192,
    'android-icon-512x512.png': 512,
    'mstile-150x150.png': 150
};

const outDirs = [
    path.join(__dirname, '..', 'theme', 'default', 'assets', 'favicons'),
    path.join(__dirname, '..', 'dist', 'assets', 'favicons')
];

function isNearWhite(r, g, b)
{
    return 244 < r && 244 < g && 244 < b;
}

(async () => {
    const input = process.argv[2];
    if(!input || !fs.existsSync(input)){
        console.error('Usage: node scripts/apply-favicon.js <source.png>');
        process.exit(1);
    }
    const image = await Jimp.read(input);
    const { width, height, data } = image.bitmap;
    console.log('Loaded', input, width + 'x' + height);

    // 1) find the bounding box of the non-white icon:
    let minX = width, minY = height, maxX = -1, maxY = -1;
    for(let y = 0; y < height; y++){
        for(let x = 0; x < width; x++){
            const idx = (y * width + x) * 4;
            if(!isNearWhite(data[idx], data[idx + 1], data[idx + 2])){
                if(x < minX){ minX = x; }
                if(x > maxX){ maxX = x; }
                if(y < minY){ minY = y; }
                if(y > maxY){ maxY = y; }
            }
        }
    }
    if(maxX < 0){
        console.error('Could not detect the icon (image looks all white).');
        process.exit(1);
    }
    let bw = maxX - minX + 1;
    let bh = maxY - minY + 1;
    // 2) make it a centered square:
    const side = Math.min(bw, bh);
    const cx = minX + Math.floor(bw / 2);
    const cy = minY + Math.floor(bh / 2);
    let sx = Math.max(0, cx - Math.floor(side / 2));
    let sy = Math.max(0, cy - Math.floor(side / 2));
    image.crop({ x: sx, y: sy, w: side, h: side });

    // 3) clean leftover near-white (rounded corners) to the dark background:
    const cropped = image.bitmap;
    for(let i = 0; i < cropped.data.length; i += 4){
        if(isNearWhite(cropped.data[i], cropped.data[i + 1], cropped.data[i + 2])){
            cropped.data[i] = 0x0e;
            cropped.data[i + 1] = 0x13;
            cropped.data[i + 2] = 0x20;
            cropped.data[i + 3] = 0xff;
        }
    }
    console.log('Cropped to square', side + 'x' + side);

    // 4) export every size into each existing target dir:
    for(const [file, size] of Object.entries(sizes)){
        const resized = image.clone().resize({ w: size, h: size, mode: ResizeStrategy.BICUBIC });
        for(const dir of outDirs){
            if(!fs.existsSync(dir)){
                continue;
            }
            await resized.clone().write(path.join(dir, file));
        }
        console.log('Wrote', file, '(' + size + 'px)');
    }
    // also drop a root favicon.png for browsers that probe it:
    const root32 = image.clone().resize({ w: 32, h: 32, mode: ResizeStrategy.BICUBIC });
    await root32.write(path.join(__dirname, '..', 'theme', 'default', 'favicon.png'));
    console.log('Done.');
})().catch((error) => {
    console.error('FAVICON_ERROR', error.message);
    process.exit(1);
});
