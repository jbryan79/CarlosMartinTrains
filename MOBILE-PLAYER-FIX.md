# Mobile Media Player Fix

## Summary

The "In His Own Voice" audio experience lives in **two places** in `index.html`:

1. **Inline voice card** (`.voice-card`, `#voice-card`) — the "IN HIS OWN VOICE"
   block inside the About section. This is where the visitor first presses play.
2. **Floating dock player** (`.dock`, `#dock`) — the slim persistent player that
   keeps the narration going (play/pause, scrubber, timecode) as the visitor
   scrolls down to read along.

## The Problem

On mobile, the floating dock player was anchored to the **bottom** of the
viewport (`bottom: 1.2rem` on desktop, `bottom: 0` on mobile). On phones this
is the worst possible spot:

- iOS Safari and Chrome render a bottom toolbar / address bar that overlaps
  anything fixed to the bottom.
- The home-indicator gesture area sits on top of it.
- The result: on the mobile site the player was partially or fully hidden,
  and the controls were hard to reach while scrolling.

## The Fix

Pin the floating dock player to the **top** of the window instead of the
bottom, and on mobile make it a **persistent sticky bar**: once the visitor
scrolls past the first picture (the hero), the dock slides down and stays
pinned at the top of the screen for the rest of the page — visible whether or
not it is currently playing — so the story can be played or stopped at any
time while scrolling.

### Changes (`index.html`)

- **`.dock`** — anchored to the top: `top` offset below the fixed nav instead
  of `bottom`; the hidden/off-screen transform slides the dock up and out of
  view above the viewport (`translate(-50%, calc(-100% - 6rem))`), and
  `.dock.is-open` brings it down to `translate(-50%, 0)`.
- **Mobile (`max-width: 900px`)** — the dock sits flush just under the nav with
  bottom-rounded corners (`border-radius: 0 0 4px 4px`), reading as a
  "now playing" bar pinned to the top of the screen. The **close button is
  hidden on mobile** so the bar stays available the whole time.
- **JS** — behavior is now split by viewport:
  - **Desktop**: unchanged — the dock appears once the inline card scrolls out
    of view while audio is playing, and hides when the card returns or the
    visitor closes it.
  - **Mobile**: a hero `IntersectionObserver` opens the dock as soon as the
    hero scrolls out of view and keeps it open for the rest of the page,
    independent of play/pause state, so it never disappears mid-scroll.

The inline voice card and the dock share the same `<audio>` element, so the
play/pause state stays in sync between the two.

## Compact Launcher

The inline launcher (`.voice-card`) was a large dark panel that felt heavy.
It is now a small, rounded **"Listen" pill** — a round play button plus a short
"In His Own Voice / Listen to Carlos tell his story" label. The whole pill is
tappable. The idle equalizer dots are hidden and only animate while the story
is playing. The persistent sticky top bar continues to handle play/pause during
scrolling.

## Testing

Open `index.html`, press play on the inline card, and scroll down. The dock
should slide in from the top and remain pinned and fully visible at the top of
the window on both mobile and desktop widths.
