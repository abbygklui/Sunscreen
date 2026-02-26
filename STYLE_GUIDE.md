# Sunscreen App - Style Guide

## Design Philosophy

**Friendly. Cute. Modern. Trustworthy.**

Sunscreen is your cheerful little companion that nudges you to protect your skin. The design should feel like a warm, encouraging friend — never nagging, always delightful. Think soft shapes, sunny colors, and playful micro-interactions.

---

## Brand Personality

| Trait | Expression |
|---|---|
| **Friendly** | Warm copy, rounded shapes, approachable typography |
| **Cute** | Playful illustrations, subtle animations, emoji-style icons |
| **Modern** | Clean layouts, generous whitespace, Material 3 design language |
| **Trustworthy** | Clear data presentation, reliable notifications, no dark patterns |

### Voice & Tone

- **Encouraging**: "You're doing great! Time to reapply." (not "WARNING: Sunscreen expired!")
- **Casual**: "It's a sunny one today!" (not "Elevated UV radiation detected.")
- **Playful**: "Your skin says thank you!" (not "Sunscreen applied successfully.")
- **Concise**: Short sentences, easy to scan at a glance.

---

## Color Palette

### Primary Colors

| Name | Hex | Usage |
|---|---|---|
| **Sunshine Yellow** | `#FFD54F` | Primary brand color, CTAs, highlights |
| **Warm Orange** | `#FFB74D` | Accent, active states, timer ring |
| **Soft Coral** | `#FF8A80` | Warnings (high UV), attention |

### Neutral Colors

| Name | Hex | Usage |
|---|---|---|
| **Cloud White** | `#FFF8E1` | Background (light mode) |
| **Cream** | `#FFECB3` | Card backgrounds, surfaces |
| **Warm Gray** | `#8D6E63` | Body text |
| **Dark Cocoa** | `#4E342E` | Headings, primary text |

### Semantic Colors

| Name | Hex | Usage |
|---|---|---|
| **UV Low (1-2)** | `#A5D6A7` | Green — low risk |
| **UV Moderate (3-5)** | `#FFD54F` | Yellow — moderate risk |
| **UV High (6-7)** | `#FFB74D` | Orange — high risk |
| **UV Very High (8-10)** | `#FF8A80` | Coral — very high risk |
| **UV Extreme (11+)** | `#E57373` | Red — extreme risk |
| **Timer Active** | `#FFB74D` | Orange countdown ring |
| **Timer Complete** | `#A5D6A7` | Green — freshly applied |

### Dark Mode (Future)

Reserve dark mode for v2. When implemented:
- Background: `#1A1210` (warm dark brown, not pure black)
- Surfaces: `#2D2220`
- Keep the sunny accent colors vibrant against dark backgrounds.

---

## Typography

### Font Family

**Primary**: `Nunito` (Google Fonts)
- Rounded, friendly letterforms
- Excellent readability at all sizes
- Free and open-source

**Fallback**: System default sans-serif

### Type Scale

| Style | Font | Size | Weight | Usage |
|---|---|---|---|---|
| **Display** | Nunito | 32sp | Bold (700) | Hero numbers (UV index, timer) |
| **Headline** | Nunito | 24sp | Bold (700) | Screen titles |
| **Title** | Nunito | 20sp | SemiBold (600) | Card headers |
| **Body Large** | Nunito | 16sp | Regular (400) | Primary body text |
| **Body** | Nunito | 14sp | Regular (400) | Secondary text, descriptions |
| **Label** | Nunito | 12sp | SemiBold (600) | Buttons, chips, captions |

### Text Color Rules

- Headings: Dark Cocoa (`#4E342E`)
- Body text: Warm Gray (`#8D6E63`)
- On colored surfaces: White (`#FFFFFF`) or Dark Cocoa, whichever has better contrast
- Links/interactive text: Warm Orange (`#FFB74D`)

---

## Spacing & Layout

### Grid

- Base unit: **8dp**
- All spacing should be multiples of 8dp: 8, 16, 24, 32, 40, 48...
- Screen horizontal padding: **24dp**

### Border Radius

| Element | Radius |
|---|---|
| Cards | 24dp (extra rounded for friendliness) |
| Buttons | 28dp (pill shape) |
| Bottom sheet | 24dp top corners |
| Small chips/badges | 12dp |
| Icons containers | Circular |

### Elevation

- Minimal use of shadows — prefer subtle color differentiation.
- Cards: 0dp elevation, use `Cream` background to differentiate from `Cloud White` page background.
- FAB / primary CTA: Soft shadow, 4dp elevation.

---

## Iconography

### Style

- **Rounded** line icons (matching Nunito's rounded feel)
- Stroke width: 2dp
- Use Material Symbols Rounded as the base icon set
- Custom illustrated icons for key features (sun, sunscreen bottle, timer)

### Key Icons

| Feature | Icon Concept |
|---|---|
| UV Alert | Sun with rays |
| Timer | Circular clock / hourglass |
| Apply button | Sunscreen bottle / lotion drop |
| Settings | Gear (rounded) |
| Location | Map pin |
| Notification | Bell |

---

## Component Specs

### "I Applied Sunscreen!" Button (Primary CTA)

```
┌─────────────────────────────────────┐
│                                     │
│     ☀️  I applied sunscreen!        │
│                                     │
└─────────────────────────────────────┘

- Shape:       Pill (stadium)
- Height:      56dp
- Background:  Sunshine Yellow (#FFD54F)
- Text:        Dark Cocoa (#4E342E), Label style, uppercase: NO
- Icon:        Sun or lotion drop, left of text
- Padding:     24dp horizontal
- Tap effect:  Subtle scale-down (0.95) + haptic feedback
- Shadow:      Soft, 4dp
```

### UV Card

```
┌────────────────────────────────────────┐
│  Today's UV                            │
│                                        │
│         ☀️                             │
│         7                              │
│       HIGH                             │
│                                        │
│  "Don't forget your sunscreen today!"  │
│                                        │
└────────────────────────────────────────┘

- Background:   Cream (#FFECB3) or UV-level color
- Border radius: 24dp
- UV number:     Display style (32sp, bold)
- UV label:      Label style, semantic color
- Message:       Body style, Warm Gray
- Padding:       24dp all sides
```

### Timer Ring

```
        ╭───────╮
       ╱  1:23   ╲
      │  remaining  │
       ╲           ╱
        ╰───────╯

- Size:          200dp x 200dp
- Ring stroke:   12dp
- Ring color:    Warm Orange (#FFB74D) → animates to Timer Complete green
- Background:    Transparent or subtle fill
- Center text:   Display style for time, Body for "remaining"
- Animation:     Smooth circular progress, updates every second
```

### Settings Row

```
┌────────────────────────────────────────┐
│  ⏱  Reapply interval      [2 hours ▾] │
└────────────────────────────────────────┘

- Height:        56dp
- Icon:          Rounded, Warm Orange
- Label:         Body Large, Dark Cocoa
- Value:         Body Large, Warm Gray, right-aligned
- Divider:       1dp, very light (#F5E6CC)
```

---

## Illustrations

### Style Guidelines

- **Flat design** with subtle texture/grain (trendy, modern)
- **Warm, sunny palette** — use brand colors
- **Rounded shapes** — circles, soft blobs, nothing sharp
- **Characters** (optional for v2): Simple, blob-like figures (think Google Doodle style)
- **Scenes**: Sun peeking through clouds, sunscreen bottles, beach vibes

### Where to Use

| Location | Illustration |
|---|---|
| Empty state (no timer) | Friendly sun holding sunscreen bottle |
| Onboarding | Sun + skin protection journey |
| Notification success | Happy sun with sunglasses |
| High UV alert | Sun with "!!" expression |

---

## Animations & Micro-interactions

| Interaction | Animation |
|---|---|
| Apply button tap | Scale down to 0.95 → bounce back, confetti burst |
| Timer start | Ring fills with color, smooth ease-in |
| Timer tick | Gentle pulse every 30 minutes |
| Timer complete | Ring turns green, celebration animation |
| UV card load | Fade in + slight slide up |
| Page transitions | Shared axis (Material motion) |
| Pull to refresh | Custom sun animation (sun rises) |

### Animation Principles

- **Duration**: 200-400ms for most transitions
- **Easing**: Use Material 3 standard easing curves
- **Restraint**: Animations should enhance, not distract
- **Purpose**: Every animation should communicate state change

---

## Notification Style

### Morning UV Alert

```
┌──────────────────────────────────────┐
│ ☀️ Sunscreen                         │
│ It's a sunny one today (UV 7)!       │
│ Don't forget your sunscreen!         │
└──────────────────────────────────────┘
```

### Reapplication Reminder

```
┌──────────────────────────────────────┐
│ 🧴 Sunscreen                         │
│ Time to reapply! Your skin will      │
│ thank you ✨                          │
│           [Reapplied!]  [Snooze]     │
└──────────────────────────────────────┘
```

### Notification Actions

- **Reapplied!** — Resets the timer for another cycle.
- **Snooze** — Delays reminder by 15 minutes.

---

## Accessibility

- **Minimum contrast**: 4.5:1 for body text, 3:1 for large text (WCAG AA).
- **Touch targets**: Minimum 48dp x 48dp.
- **Screen reader**: All icons have semantic labels. Timer announces remaining time.
- **Reduced motion**: Respect `MediaQuery.disableAnimations`. Provide static alternatives.
- **Font scaling**: Support system font size preferences up to 200%.

---

## Do's and Don'ts

### Do

- Use warm, encouraging language
- Keep the UI clean and scannable
- Use generous padding and whitespace
- Make the apply button prominent and satisfying to tap
- Use color to communicate UV severity at a glance
- Test on various screen sizes (small phones to tablets)

### Don't

- Use harsh or alarming language ("DANGER!", "WARNING!")
- Clutter the home screen with too many elements
- Use sharp corners or angular design elements
- Use pure black (#000000) anywhere — always use warm dark tones
- Skip accessibility considerations
- Add features that distract from the two core functions
