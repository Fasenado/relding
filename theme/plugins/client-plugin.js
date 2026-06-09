/**
 *
 * Reldens - Theme - Client Plugin
 *
 */

const { PluginInterface } = require('reldens/lib/features/plugin-interface');
const { Npc1 } = require('./objects/client/npc1');

class ClientPlugin extends PluginInterface
{

    setup(props)
    {
        this.events = props.events;
        this.events.on('reldens.beforeJoinGame', (props) => {
            this.defineCustomClasses(props);
        });
        // tweak the rendering look just before the Phaser engine is created:
        this.events.on('reldens.beforeCreateEngine', (initialGameData, gameManager) => {
            this.applyEngineLook(initialGameData, gameManager);
        });
        // zoom each map so it covers the whole viewport (no black bars on wide/ultrawide screens):
        this.events.on('reldens.afterSceneDynamicCreate', (sceneDynamic) => {
            this.activeScene = sceneDynamic;
            this.fitCameraCover(sceneDynamic);
            this.arrangeHud();
            // mute the engine's old looping town track; the modern fantasy loop plays as background:
            this.silenceEngineMusic(sceneDynamic);
        });
        // recompute the cover zoom when the window is resized:
        if(typeof window !== 'undefined'){
            window.addEventListener('resize', () => {
                clearTimeout(this.resizeTimer);
                this.resizeTimer = setTimeout(() => {
                    this.fitCameraCover(this.activeScene);
                    this.arrangeHud();
                }, 200);
            });
        }
    }

    silenceEngineMusic(sceneDynamic)
    {
        // Mute the engine's built-in looping background tracks (e.g. reldens-town) so they don't
        // fight the modern fantasy loop. Short SFX (footsteps, skills) are left untouched.
        let game = sceneDynamic && sceneDynamic.sys && sceneDynamic.sys.game;
        if(!game || !game.sound){
            return;
        }
        let mute = () => {
            let sounds = game.sound.sounds || [];
            for(let sound of sounds){
                if(sound && sound.loop){
                    if('function' === typeof sound.setMute){
                        sound.setMute(true);
                    } else {
                        sound.mute = true;
                    }
                }
            }
        };
        mute();
        // the scene's background track can start a moment after the scene is created, so re-apply:
        setTimeout(mute, 600);
        setTimeout(mute, 1500);
        setTimeout(mute, 3500);
    }

    arrangeHud()
    {
        // Some HUD buttons live inside a blurred/transformed container, which becomes the containing
        // block for position:fixed and throws them off. Re-parent them to <body> so the fixed-position
        // rails in the CSS anchor to the viewport.
        let strayIds = ['minimap-open'];
        let move = () => {
            for(let id of strayIds){
                let element = document.getElementById(id);
                if(element && element.parentElement !== document.body){
                    document.body.appendChild(element);
                }
            }
        };
        move();
        setTimeout(move, 500);
    }

    applyEngineLook(initialGameData, gameManager)
    {
        let clientConfigs = [
            initialGameData && initialGameData.gameConfig && initialGameData.gameConfig.client,
            gameManager && gameManager.config && gameManager.config.client
        ];
        for(let clientConfig of clientConfigs){
            if(!clientConfig){
                continue;
            }
            if(clientConfig.gameEngine){
                // dark themed clear color so areas around small maps look intentional, not "broken":
                clientConfig.gameEngine.backgroundColor = '#0b0f18';
                // remove the 1280px render cap so the viewport uses the full widescreen width:
                clientConfig.gameEngine.scale = clientConfig.gameEngine.scale || {};
                clientConfig.gameEngine.scale.max = { width: 5000, height: 5000 };
            }
            // disable the UI "maximum" size cap so the camera fills the container, not just 1280px:
            clientConfig.ui = clientConfig.ui || {};
            clientConfig.ui.maximum = clientConfig.ui.maximum || {};
            clientConfig.ui.maximum.enabled = false;
            // disable map-sized camera centering; it offsets the viewport and fights the cover zoom:
            clientConfig.ui.screen = clientConfig.ui.screen || {};
            clientConfig.ui.screen.centerSmallMapsCamera = false;
            // show floating nicknames above every player, including your own avatar:
            clientConfig.ui.players = clientConfig.ui.players || {};
            clientConfig.ui.players.showNames = true;
            clientConfig.ui.players.showCurrentPlayerName = true;
            // lift the label above the head: label y = sprite.y - height - spriteHeight + topOffset,
            // so a positive height moves it up (the stock -90 pushes it below the feet):
            clientConfig.ui.players.nameText = clientConfig.ui.players.nameText || {};
            clientConfig.ui.players.nameText.height = 20;
        }
    }

    fitCameraCover(sceneDynamic)
    {
        if(!sceneDynamic || !sceneDynamic.cameras || !sceneDynamic.map){
            return;
        }
        let applyZoom = () => {
            let camera = sceneDynamic.cameras.main;
            if(!camera){
                return;
            }
            let viewWidth = camera.width;
            let viewHeight = camera.height;
            if(!viewWidth || !viewHeight){
                return;
            }
            // measure the actual tiled area (the room), ignoring empty map borders:
            let content = this.getContentSize(sceneDynamic.map);
            if(!content){
                return;
            }
            // "cover" the content so it fills the viewport; cap so interiors don't over-zoom:
            let zoom = Math.max(viewWidth / content.width, viewHeight / content.height);
            zoom = Math.max(1, Math.min(zoom, 2.8));
            camera.setZoom(zoom);
        };
        applyZoom();
        // re-apply after the player camera (bounds/follow) is configured so the zoom sticks:
        setTimeout(applyZoom, 500);
    }

    getContentSize(map)
    {
        if(!map || !map.layers){
            return null;
        }
        let tileWidth = map.tileWidth || 32;
        let tileHeight = map.tileHeight || 32;
        let minX = Infinity, minY = Infinity, maxX = -Infinity, maxY = -Infinity;
        for(let layer of map.layers){
            let data = layer && layer.data;
            if(!data){
                continue;
            }
            for(let y = 0; y < data.length; y++){
                let row = data[y];
                if(!row){
                    continue;
                }
                for(let x = 0; x < row.length; x++){
                    let tile = row[x];
                    if(tile && 0 < tile.index){
                        if(x < minX){ minX = x; }
                        if(x > maxX){ maxX = x; }
                        if(y < minY){ minY = y; }
                        if(y > maxY){ maxY = y; }
                    }
                }
            }
        }
        if(minX === Infinity){
            // fall back to the full map size if we couldn't read tiles:
            let fullW = map.widthInPixels || (map.width * tileWidth);
            let fullH = map.heightInPixels || (map.height * tileHeight);
            return (fullW && fullH) ? { width: fullW, height: fullH } : null;
        }
        return {
            width: (maxX - minX + 1) * tileWidth,
            height: (maxY - minY + 1) * tileHeight
        };
    }

    defineCustomClasses(props)
    {
        // example on how to define a custom class with a plugin:
        let customClasses = props.gameManager.config.client.customClasses;
        if(!customClasses['objects']){
            customClasses.objects = {};
        }
        customClasses.objects['people_town_1'] = Npc1;
    }

}

module.exports.ClientPlugin = ClientPlugin;
