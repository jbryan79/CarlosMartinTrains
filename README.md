# Carlos Martin — Personal Training Website

Live site: [carlos-martin-training.netlify.app](http://carlos-martin-training.netlify.app)

## Project Files

| File | Description |
|------|-------------|
| `index.html` | Full website — single page, no dependencies |
| `carlos-hero.png` | Hero portrait photo (right column, above fold) |
| `carlos-about.jpg` | Gym photo, edited for definition (About section) |
| `carlos-story.mp3` | Carlos narrating his story — powers the "In His Own Voice" player |

## "In His Own Voice" Audio

The About section has a custom audio player. Visitors press play to hear
Carlos tell his story; a floating dock player keeps the narration going as
they scroll through the About and Comeback sections, so they can read along.
To replace the narration, swap `carlos-story.mp3` (keep the same filename)
and push — no code changes needed.

## Stack

- Plain HTML/CSS — no frameworks, no build step
- Hosted on Netlify (free tier)
- Contact form handled by Netlify Forms (built-in, no backend)

## Deploying Updates

1. Edit `index.html` locally
2. Push to Git — Netlify auto-deploys on push (if repo is connected)
   **or** drag the folder into [app.netlify.com](https://app.netlify.com) to deploy manually

## Contact Form Setup

Form submissions go to Carlos's email via Netlify Forms.
To configure/verify the email notification:
1. Netlify dashboard → **carlos-martin-training** → **Forms**
2. Click **contact** form → **Form notifications**
3. Confirm email is set to `carlos_martin21@yahoo.com`

## Contact & Social

- Email: carlos_martin21@yahoo.com
- Instagram: [@carlosmartin2136](https://instagram.com/carlosmartin2136)

## Credits

Built by [JAB Systems](https://jabsystems.io)
