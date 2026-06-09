/**
 *
 * Reldens - Theme - Server Plugin
 *
 */

const path = require('path');
const fs = require('fs');
const { Healer } = require('./objects/server/healer');
const { QuestNpc } = require('./objects/server/quest-npc');
const { WeaponsMaster } = require('./objects/server/weapons-master');
const { PluginInterface } = require('reldens/lib/features/plugin-interface');

class ServerPlugin extends PluginInterface
{

    setup(props)
    {
        this.events = props.events;
        this.events.on('reldens.beforeInitializeManagers', (props) => {
            this.defineCustomClasses(props);
        });
        // register the standalone Docs page and the guide image assets:
        this.events.on('reldens.serverBeforeListen', (props) => {
            this.registerDocsRoutes(props.serverManager.app);
        });
    }

    registerDocsRoutes(app)
    {
        if(!app){
            return;
        }
        let guideDir = path.join(__dirname, 'guide');
        // allow-list of guide images to avoid any path traversal:
        let allowedImages = {
            'guide-move.png': true,
            'guide-explore.png': true,
            'guide-target.png': true
        };
        app.get('/docs', (req, res) => {
            res.sendFile(path.join(guideDir, 'docs.html'));
        });
        app.get('/guide/:file', (req, res) => {
            let file = req.params.file;
            if(!allowedImages[file]){
                res.status(404).send('Not found');
                return;
            }
            res.sendFile(path.join(guideDir, file));
        });
        // modern background music (drop a file in theme/plugins/media/ to enable it):
        let mediaDir = path.join(__dirname, 'media');
        let allowedMedia = {
            'theme.mp3': 'audio/mpeg',
            'theme.ogg': 'audio/ogg',
            'theme.wav': 'audio/wav'
        };
        app.get('/media/:file', (req, res) => {
            let file = req.params.file;
            let mime = allowedMedia[file];
            let full = path.join(mediaDir, file);
            if(!mime || !fs.existsSync(full)){
                res.status(404).send('Not found');
                return;
            }
            res.type(mime);
            res.sendFile(full);
        });
    }

    defineCustomClasses(props)
    {
        let customClasses = props.serverManager.configManager.configList.server.customClasses;
        if(!customClasses['objects']){
            customClasses.objects = {};
        }
        if(!customClasses['roomsClass']){
            customClasses.roomsClass = {};
        }
        // @TODO - BETA - Clean up all the custom classes, by default these can be all default objects with all the
        //   data coming from the storage. Leave just a custom class as sample like the "Npc1" on the client-plugin.
        customClasses.objects['npc_2'] = Healer;
        customClasses.objects['npc_4'] = WeaponsMaster;
        customClasses.objects['npc_5'] = QuestNpc;
    }

}

module.exports.ServerPlugin = ServerPlugin;
