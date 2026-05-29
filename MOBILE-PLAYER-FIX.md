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
bottom, so it stays visible and tappable as the visitor scrolls. The dock now
slides **down** into view (from above) just beneath the fixed navigation bar,
rather than sliding up from the bottom.

### Changes (`index.html`, CSS only — no markup or JS logic changed)

- **`.dock`** — anchored to the top: `top` offset below the fixed nav instead
  of `bottom`; the hidden/off-screen transform now slides the dock up and out
  of view above the viewport (`translate(-50%, calc(-100% - 6rem))`), and
  `.dock.is-open` brings it down to `translate(-50%, 0)`.
- **Mobile (`max-width: 900px`)** — the dock sits flush just under the nav with
  bottom-rounded corners (`border-radius: 0 0 4px 4px`) so it reads as a
  "now playing" bar pinned to the top of the screen.

The reveal logic is unchanged: the dock still appears automatically once the
inline card scrolls out of view while audio is playing, and hides again when
the card returns or the visitor closes it.

## Testing

Open `index.html`, press play on the inline card, and scroll down. The dock
should slide in from the top and remain pinned and fully visible at the top of
the window on both mobile and desktop widths.
