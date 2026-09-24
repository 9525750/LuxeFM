# Luxe FM

Internet radio station frontend — minimalist dark luxury player site.

## Stack

- Static HTML/CSS/JS (no build step)
- Fonts: Cormorant Garamond (display), Jost (body) via Google Fonts
- Palette: dark background (#0a0a0a) + gold/champagne (#c9a96e)

## Architecture

- `index.html` — self-contained player page
- Connects to Icecast stream at `/stream`
- Polls LibreTime Live Info API at `/api/live-info-v2/` for "now playing" metadata

## Configuration

Stream URL and API endpoint are set in `CONFIG` object inside `index.html`.
Update these when deploying behind a reverse proxy or to match your LibreTime setup.
