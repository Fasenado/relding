/**
 * Generate a seamless fantasy ambient background loop and encode it to MP3.
 *
 * Pure synthesis (no external audio assets): a warm chord pad + soft bass + a harp-like
 * arpeggio over a classic minor "fantasy" progression (Am - F - C - G), with a few echo taps
 * for space. Per-bar envelopes + circular echoes make it loop without clicks.
 *
 * Output: theme/plugins/media/theme.mp3  (the in-game music layer prefers this file)
 * Usage: node scripts/generate-music.js
 */
const fs = require('fs');
const path = require('path');

const SR = 44100;
const BPM = 64;
const beat = 60 / BPM;
const barBeats = 4;
const bar = beat * barBeats;
const progression = ['Am', 'F', 'C', 'G', 'Am', 'F', 'C', 'G'];
const totalBars = progression.length;
const duration = bar * totalBars;
const N = Math.floor(duration * SR);

const L = new Float64Array(N);
const R = new Float64Array(N);

const chords = {
    Am: { bass: 110.00, notes: [220.00, 261.63, 329.63], arp: [220.00, 261.63, 329.63, 440.00] },
    F:  { bass: 87.31,  notes: [174.61, 220.00, 261.63], arp: [174.61, 261.63, 349.23, 440.00] },
    C:  { bass: 130.81, notes: [196.00, 261.63, 329.63], arp: [196.00, 261.63, 392.00, 523.25] },
    G:  { bass: 98.00,  notes: [196.00, 246.94, 293.66], arp: [246.94, 293.66, 392.00, 493.88] }
};

function panGains(pan)
{
    let a = (pan + 1) / 2 * Math.PI / 2;
    return [Math.cos(a), Math.sin(a)];
}

// sustained, warm voice (pad / bass) with attack-release envelope and gentle vibrato:
function addPad(freq, start, dur, amp, pan, harmonics, vibrato)
{
    let s0 = Math.floor(start * SR);
    let s1 = Math.min(N, Math.floor((start + dur) * SR));
    let attack = 0.12;
    let release = 0.35;
    let [lg, rg] = panGains(pan);
    for(let i = s0; i < s1; i++){
        let t = (i - s0) / SR;
        let e = t < attack ? (t / attack) : (t > dur - release ? Math.max(0, (dur - t) / release) : 1);
        let vib = vibrato ? (1 + 0.004 * Math.sin(2 * Math.PI * 5 * t)) : 1;
        let v = 0;
        for(let h = 0; h < harmonics.length; h++){
            let hf = freq * (h + 1) * vib;
            v += harmonics[h] * (Math.sin(2 * Math.PI * hf * t) + 0.5 * Math.sin(2 * Math.PI * hf * 1.005 * t));
        }
        v *= amp * e;
        L[i] += v * lg;
        R[i] += v * rg;
    }
}

// plucked, harp/bell-like note with fast exponential decay:
function addPluck(freq, start, dur, amp, pan)
{
    let s0 = Math.floor(start * SR);
    let s1 = Math.min(N, Math.floor((start + dur) * SR));
    let [lg, rg] = panGains(pan);
    for(let i = s0; i < s1; i++){
        let t = (i - s0) / SR;
        let e = Math.exp(-t * 3.2);
        let v = amp * e * (
            Math.sin(2 * Math.PI * freq * t)
            + 0.32 * Math.sin(2 * Math.PI * 2 * freq * t)
            + 0.16 * Math.sin(2 * Math.PI * 3 * freq * t)
        );
        L[i] += v * lg;
        R[i] += v * rg;
    }
}

for(let b = 0; b < totalBars; b++){
    let chord = chords[progression[b]];
    let t0 = b * bar;
    for(let f of chord.notes){
        addPad(f, t0, bar, 0.095, 0, [1, 0.5, 0.25, 0.12], true);
    }
    addPad(chord.bass, t0, bar, 0.17, 0, [1, 0.4, 0.16], false);
    let steps = 8;
    let stepDur = bar / steps;
    for(let s = 0; s < steps; s++){
        let f = chord.arp[s % chord.arp.length];
        if(6 === s){ f *= 2; } // small lift near the end of the bar
        let pan = (0 === s % 2) ? -0.35 : 0.35;
        addPluck(f, t0 + s * stepDur, stepDur * 2.2, 0.16, pan);
    }
}

// circular echo taps for a sense of space (wrap around so the loop stays seamless):
function addEchoes(buf)
{
    let taps = [[0.149, 0.26], [0.211, 0.18], [0.370, 0.10]];
    let dry = Float64Array.from(buf);
    for(let [time, gain] of taps){
        let d = Math.floor(time * SR);
        for(let i = 0; i < N; i++){
            buf[i] += gain * dry[(i - d + N) % N];
        }
    }
}
addEchoes(L);
addEchoes(R);

// normalize to a comfortable peak and soft-clip:
let peak = 0;
for(let i = 0; i < N; i++){
    peak = Math.max(peak, Math.abs(L[i]), Math.abs(R[i]));
}
let norm = peak > 0 ? (0.85 / peak) : 1;
let li16 = new Int16Array(N);
let ri16 = new Int16Array(N);
for(let i = 0; i < N; i++){
    let l = Math.tanh(L[i] * norm);
    let r = Math.tanh(R[i] * norm);
    li16[i] = Math.max(-32768, Math.min(32767, Math.round(l * 32767)));
    ri16[i] = Math.max(-32768, Math.min(32767, Math.round(r * 32767)));
}

(async () => {
    const { Mp3Encoder } = await import('@breezystack/lamejs');
    let encoder = new Mp3Encoder(2, SR, 160);
    let blockSize = 1152;
    let chunks = [];
    for(let i = 0; i < N; i += blockSize){
        let left = li16.subarray(i, i + blockSize);
        let right = ri16.subarray(i, i + blockSize);
        let buf = encoder.encodeBuffer(left, right);
        if(buf.length > 0){
            chunks.push(Buffer.from(buf));
        }
    }
    let end = encoder.flush();
    if(end.length > 0){
        chunks.push(Buffer.from(end));
    }
    let mp3 = Buffer.concat(chunks);
    let outDir = path.join(__dirname, '..', 'theme', 'plugins', 'media');
    fs.mkdirSync(outDir, { recursive: true });
    let outFile = path.join(outDir, 'theme.mp3');
    fs.writeFileSync(outFile, mp3);
    console.log('Wrote', outFile, (mp3.length / 1024).toFixed(0) + ' KB', '| duration', duration.toFixed(1) + 's');
})().catch((e) => { console.error('GEN_ERROR', e.message); process.exit(1); });
