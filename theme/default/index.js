/**
 *
 * Reldens - Index
 *
 */

if(window.trustedTypes?.createPolicy){
    trustedTypes.createPolicy('default', {
        createHTML: s => s,
        createScriptURL: s => s
    });
}

// to set logger level and trace, this needs to be specified before the game manager is required:
const urlParams = new URLSearchParams(window.location.search);
window.RELDENS_LOG_LEVEL = (urlParams.get('logLevel') || 7);
window.RELDENS_ENABLE_TRACE_FOR = Number(urlParams.get('traceFor') || 'emergency,alert,critical');
// debug events (warning! this will output in the console ALL the event listeners and every event fired):
// reldens.events.debug = 'all';

const { GameManager } = require('reldens/client');
const { ClientPlugin } = require('../plugins/client-plugin');

let reldens = new GameManager();
// @NOTE: you can specify your game server and your app server URLs in case you serve the client static files from
// a different location.
// reldens.gameServerUrl = 'wss://localhost:8000';
// reldens.appServerUrl = 'https://localhost:8000';
reldens.setupCustomClientPlugin('customPluginKey', ClientPlugin);
window.addEventListener('DOMContentLoaded', () => {
    reldens.clientStart();
    setupAuthUi();
    setupBackgroundMusic();
    setupContractAddress();
});

// copy-to-clipboard for the token contract address shown on the login screen:
function setupContractAddress()
{
    let button = document.querySelector('#ca-copy');
    let address = document.querySelector('#ca-address');
    if(!button || !address){
        return;
    }
    let label = button.querySelector('.ca-copy-label');
    button.addEventListener('click', async () => {
        let value = address.textContent.trim();
        try {
            if(navigator.clipboard?.writeText){
                await navigator.clipboard.writeText(value);
            } else {
                let range = document.createRange();
                range.selectNodeContents(address);
                let selection = window.getSelection();
                selection.removeAllRanges();
                selection.addRange(range);
                document.execCommand('copy');
                selection.removeAllRanges();
            }
            button.classList.add('is-copied');
            if(label){
                label.textContent = 'Copied!';
            }
            setTimeout(() => {
                button.classList.remove('is-copied');
                if(label){
                    label.textContent = 'Copy';
                }
            }, 1600);
        } catch (error) {
            // clipboard not available; leave the address visible for manual copy
        }
    });
}

// Modern background music layer. Plays /media/theme.mp3 (served by the server plugin) on a loop
// with a mute toggle, starting on the first user gesture to satisfy browser autoplay rules.
// If no track is present it stays completely silent and adds no UI.
async function setupBackgroundMusic()
{
    // prefer a real modern track (mp3/ogg); fall back to the bundled silent placeholder (wav):
    let candidates = ['/media/theme.mp3', '/media/theme.ogg', '/media/theme.wav'];
    let track = '';
    for(let candidate of candidates){
        try {
            let response = await fetch(candidate, { method: 'HEAD' });
            if(response.ok){
                track = candidate;
                break;
            }
        } catch (error) {
            // try the next candidate
        }
    }
    if(!track){
        return;
    }
    let muted = '1' === localStorage.getItem('relding-music-muted');
    let audio = document.createElement('audio');
    audio.id = 'relding-bg-music';
    audio.loop = true;
    audio.preload = 'auto';
    audio.src = track;
    audio.volume = 0.45;
    audio.muted = muted;
    document.body.appendChild(audio);

    let toggle = document.createElement('button');
    toggle.id = 'relding-music-toggle';
    toggle.type = 'button';
    toggle.setAttribute('aria-label', 'Toggle music');
    let render = () => {
        toggle.textContent = '\u266A';
        toggle.classList.toggle('is-muted', audio.muted);
    };
    render();
    document.body.appendChild(toggle);

    let tryPlay = () => {
        let attempt = audio.play();
        if(attempt && attempt.catch){
            attempt.catch(() => {});
        }
    };
    toggle.addEventListener('click', () => {
        audio.muted = !audio.muted;
        localStorage.setItem('relding-music-muted', audio.muted ? '1' : '0');
        if(!audio.muted){
            tryPlay();
        }
        render();
    });
    let startOnce = () => {
        if(!audio.muted){
            tryPlay();
        }
    };
    window.addEventListener('pointerdown', startOnce, { once: true });
    if(!muted){
        tryPlay();
    }
}

// modern auth UI: how-to-play modal + Phantom (Solana) wallet login:
function setupAuthUi()
{
    // how to play -> show instructions overlay:
    let howToPlay = document.querySelector('#how-to-play-link');
    let instructions = document.querySelector('#instructions');
    if(howToPlay && instructions){
        howToPlay.addEventListener('click', (e) => {
            e.preventDefault();
            // load guide screens lazily (kept in data-src so the bundler doesn't try to resolve them):
            instructions.querySelectorAll('.howto-shot[data-src]').forEach((img) => {
                img.src = img.getAttribute('data-src');
                img.removeAttribute('data-src');
            });
            instructions.classList.remove('hidden');
        });
        let close = instructions.querySelector('#instructions-close');
        close?.addEventListener('click', () => instructions.classList.add('hidden'));
    }
    // phantom wallet login (main card button + topbar button):
    document.querySelector('#phantom-login-btn')?.addEventListener('click', () => loginWithPhantom());
    document.querySelector('#connect-wallet-btn')?.addEventListener('click', () => loginWithPhantom());
}

// returns the injected Phantom provider, or null when it is not installed:
function getPhantomProvider()
{
    if(window.phantom?.solana?.isPhantom){
        return window.phantom.solana;
    }
    if(window.solana?.isPhantom){
        return window.solana;
    }
    return null;
}

function setWalletStatus(message, isError)
{
    let status = document.querySelector('#wallet-status');
    if(!status){
        return;
    }
    status.textContent = message || '';
    status.classList.toggle('hidden', !message);
    status.classList.toggle('is-error', Boolean(isError));
}

function setWalletLoading(isLoading)
{
    let btn = document.querySelector('#phantom-login-btn');
    if(!btn){
        return;
    }
    btn.disabled = isLoading;
    btn.classList.toggle('is-loading', isLoading);
    let label = btn.querySelector('.wallet-btn-label');
    if(label){
        label.textContent = isLoading ? 'Connecting…' : 'Connect Phantom';
    }
}

function bytesToHex(bytes)
{
    let hex = '';
    for(let i = 0; i < bytes.length; i++){
        hex += bytes[i].toString(16).padStart(2, '0');
    }
    return hex;
}

let phantomLoginInProgress = false;

// Connect Phantom, prove wallet ownership via a deterministic ed25519 signature, and use the wallet
// address + signature as Reldens credentials. Same wallet => same signature => same account on every login.
async function loginWithPhantom()
{
    if(phantomLoginInProgress){
        return;
    }
    let provider = getPhantomProvider();
    if(!provider){
        setWalletStatus('Phantom wallet not found. Install it to continue.', true);
        document.querySelector('#phantom-install-link')?.classList.remove('hidden');
        window.open('https://phantom.app/download', '_blank', 'noopener');
        return;
    }
    phantomLoginInProgress = true;
    setWalletLoading(true);
    setWalletStatus('Connecting to Phantom…', false);
    try {
        let connection = await provider.connect();
        let publicKey = (connection?.publicKey || provider.publicKey).toString();
        setWalletStatus('Approve the signature request in Phantom…', false);
        let message = 'Sign in to Relding with your Solana wallet.\nWallet: ' + publicKey;
        let encodedMessage = new TextEncoder().encode(message);
        let signed = await provider.signMessage(encodedMessage, 'utf8');
        let signature = signed?.signature || signed;
        let credentials = {
            formId: 'login-form',
            username: publicKey,
            email: publicKey + '@phantom.relding',
            password: bytesToHex(signature)
        };
        credentials.rePassword = credentials.password;
        setWalletStatus('Signing in…', false);
        let started = await window.reldens.startGame(credentials, true);
        if(!started){
            window.reldens.submitedForm = false;
            setWalletStatus('Could not sign in with this wallet. Please try again.', true);
            setWalletLoading(false);
            phantomLoginInProgress = false;
        }
    } catch (error) {
        let rejected = error && (4001 === error.code || /reject|cancel/i.test(error.message || ''));
        setWalletStatus(
            rejected ? 'Request cancelled in Phantom.' : 'Wallet connection failed. Please try again.',
            true
        );
        setWalletLoading(false);
        phantomLoginInProgress = false;
    }
}

// client event listener example with version display:
reldens.events.on('reldens.afterInitEngineAndStartGame', () => {
    reldens.gameDom.getElement('#current-version').innerHTML = reldens.config.client.gameEngine.version+' -';
});

// demo message removal:
reldens.events.on('reldens.startGameAfter', () => {
    reldens.gameDom.getElement('.row-disclaimer')?.remove();
});

reldens.events.on('reldens.activateRoom', (room) => {
    room.onMessage('*', (message) => {
        // @TODO - BETA - Replace 'rski.Bc' by the constant ACTION_SKILL_BEFORE_CAST, standardize events names.
        // filter skills before the cast message:
        if('rski.Bc' !== message.act){
            return;
        }
        // skills cold down animation sample:
        let skillKey = (message.data?.skillKey || '').toString();
        let skillDelay = Number(message.data?.extraData?.sd || 0);
        if('' !== skillKey && 0 < skillDelay){
            let skillElement = reldens.gameDom.getElement('.skill-icon-'+skillKey);
            if(!skillElement){
                return;
            }

            let startTime = Date.now();
            let endTime = startTime + skillDelay;

            function updateCooldown() {
                let currentTime = Date.now();
                let remainingTime = endTime - currentTime;
                if(0 >= remainingTime){
                    skillElement.style.setProperty('--angle', '360deg');
                    skillElement.classList.remove('cooldown');
                    return;
                    // stop the animation when time is up.
                }
                let progress = (skillDelay - remainingTime) / skillDelay;
                let angle = progress * 360;
                skillElement.style.setProperty('--angle', `${angle}deg`);
                requestAnimationFrame(updateCooldown);
            }

            skillElement.classList.add('cooldown');
            skillElement.style.setProperty('--angle', '0deg');
            updateCooldown();
        }
    });
});

// global access is not actually required, the app can be fully encapsulated:
window.reldens = reldens;
