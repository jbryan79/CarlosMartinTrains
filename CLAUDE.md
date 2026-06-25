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

The site is two HTML files at the repo root: `index.html` (the main page, ~46 KB / ~1200 lines, single-file source of truth) and `waiver.html` (standalone liability waiver page). Both follow the same pattern — all styles in one `<style>` block in the `<head>`, all JS in one `<script>` block at the bottom. Edit each in place rather than splitting them up unless the user asks.

`index.html` sections (in document order, by `id`): `hero`, `about`, `comeback`, `philosophy`, `skills`, `pricing`, `contact`.

Three pieces of behavior that need care when editing:

1. **"In His Own Voice" audio player.** A single `<audio id="story-audio" src="carlos-story.mp3">` element is shared between an inline player in `#about` and a floating dock player that appears while the user scrolls through `#about`/`#comeback`. Both UIs bind to the same element, so swapping the file or renaming the id will break both. To replace the narration, keep the filename `carlos-story.mp3`.
2. **Contact form** in `index.html#contact` uses Netlify Forms (`<form name="contact" method="POST" data-netlify="true" netlify-honeypot="bot-field">`). The `name="contact"` attribute is the form identifier Netlify uses — don't rename it. Submissions are emailed via the form notification configured in the Netlify dashboard (see README).
3. **Waiver form** in `waiver.html` is a *second* Netlify Form, `name="waiver"`. It captures personal info plus a drawn signature (via the `signature_pad` library loaded from jsDelivr CDN) as a base64 PNG in a hidden `signature` field. Submission is AJAX (`fetch` POST to `/`), so the hidden `<input name="form-name" value="waiver">` is required for Netlify to route it. Email notification for this form needs to be configured separately in the Netlify dashboard. The waiver text in the page is **placeholder language** marked with an HTML comment — replace it with Carlos's actual lawyer-reviewed waiver before relying on it.

`index_old.html`, `index_older.html`, `index_redesign.html` are historical snapshots — not used by the deploy. Don't edit them unless the user asks.

## Repo hygiene

- Large media (audio/video/images) lives in the repo root and is committed directly.
- `push-to-main.bat` is a one-off recovery script that uses `git-filter-repo` to strip specific oversized files (`output_audio.wav`, an old `.mp4`) from history and force-pushes `main`. Only run it if the user explicitly asks — it rewrites history and force-pushes.
