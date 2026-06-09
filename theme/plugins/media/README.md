# Background music

Drop a track here to set the in-game background music. The client looks for these files
(in order) and serves them via the `/media/:file` route:

1. `theme.mp3`  (recommended)
2. `theme.ogg`
3. `theme.wav`  (a 1‑second silent placeholder ships here so the music toggle is live)

To use a real modern track, add `theme.mp3` to this folder and restart the server. A floating
music toggle (bottom‑left) lets players mute/unmute; the choice is remembered per browser.

## Where to get CC0 (no-attribution) music

- Pixabay Music — https://pixabay.com/music/ (filter by genre, e.g. "electronic"/"lo-fi")
- OpenGameArt CC0 — https://opengameart.org/art-search-advanced (License: CC0, Art Type: Music)
- Free Music Archive (CC0 filter) — https://freemusicarchive.org/

Pick a loop-friendly track, rename it to `theme.mp3`, and place it here.

## Replacing the engine's own scene music

The engine also plays a per-scene track (`reldens-town.mp3`). To silence it so only this modern
track plays, open the in-game Settings (gear icon) → Audio and turn the scene/background
category off, or replace `dist/assets/audio/reldens-town.mp3` with your own file.
