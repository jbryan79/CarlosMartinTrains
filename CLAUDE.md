# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Single-page marketing site for Carlos Martin (personal trainer). Live at carlos-martin-training.netlify.app.

## Stack & build

- Plain HTML/CSS/JS in a single file — **no build step, no package manager, no frameworks**.
- `netlify.toml` just sets `publish = "."` so the repo root is the deploy root.
- To preview locally, open `index.html` in a browser. There is no dev server / test suite / linter.
- Deploy = push to `main`; Netlify auto-deploys.

## Architecture

Everything lives in `index.html` (~46 KB, ~1200 lines). All styles are in one `<style>` block in the `<head>`; all JS is in one `<script>` block at the bottom. Sections (in document order, by `id`): `hero`, `about`, `comeback`, `philosophy`, `skills`, `pricing`, `contact`. Treat `index.html` as the single source of truth — edit in place rather than splitting it up unless the user asks.

Two pieces of behavior that span multiple sections and need care when editing:

1. **"In His Own Voice" audio player.** A single `<audio id="story-audio" src="carlos-story.mp3">` element is shared between an inline player in `#about` and a floating dock player that appears while the user scrolls through `#about`/`#comeback`. Both UIs bind to the same element, so swapping the file or renaming the id will break both. To replace the narration, keep the filename `carlos-story.mp3`.
2. **Contact form** in `#contact` uses Netlify Forms (`<form name="contact" method="POST" data-netlify="true" netlify-honeypot="bot-field">`). The `name="contact"` attribute is the form identifier Netlify uses — don't rename it. Submissions are emailed via the form notification configured in the Netlify dashboard (see README).

`index_old.html`, `index_older.html`, `index_redesign.html` are historical snapshots — not used by the deploy. Don't edit them unless the user asks.

## Repo hygiene

- Large media (audio/video/images) lives in the repo root and is committed directly.
- `push-to-main.bat` is a one-off recovery script that uses `git-filter-repo` to strip specific oversized files (`output_audio.wav`, an old `.mp4`) from history and force-pushes `main`. Only run it if the user explicitly asks — it rewrites history and force-pushes.
