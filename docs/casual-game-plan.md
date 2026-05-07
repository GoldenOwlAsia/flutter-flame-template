# Casual Game — Planning Document

---

## 1. Game Design

- Game mechanics document (rules, edge cases)
- Level progression curve (easy → hard)
- 50–200 hand-crafted levels (or procedural + curated)
- Economy design: coins, hints, extra time pricing
- Monetization model: rewarded ads, IAP, paywall placement

---

## 2. Art & Design Assets

| Category | Details |
|---|---|
| **Common Screens** | Menu, Pause, Game Over, Reward |
| **Game Play** | Game board, Effects |
| **SFX & Sound** | SFX, BGM |
| **App Assets** | Icon, Screenshots, Store listing |

---

## 3. Develop (Flutter + Flame)

- Use template: <https://github.com/GoldenOwlAsia/flutter-flame-template>
- Use AI agent — Cursor

### Core Template Updates

- Integrate AdMob (banner top/bottom, interstitial and rewarded video after app open or level complete)
- Integrate IAP (extra time, hints, remove ads)
- Settings screen (privacy policy, required for store submission)
- Game Center integration (user ID, leaderboard)
- Firebase Analytics (essential for gameplay optimization and user retention)

### Common Screens

- Revamp UI for Menu, Pause, Game Over, Reward

### Gameplay & Level System

- Mechanic prototype, art style, sound, effects, animations
- First playable level
- Next 20 levels
- 100–200 levels

---

## 4. Timeline

| Phase | Details | Owner | Estimate |
|---|---|---|---|
| **Game Design** | GDD, mechanics, level progression, economy | Game Designer | 1–3 days |
| **Art & Design** | Common screens, gameplay assets, SFX, BGM, app assets | Art Designer | 3–5 days |
| **Core Template** | Ads, IAP, Analytics, Game Center, Settings | Developer | 3–5 days |
| **Common Screens** | Revamp Menu, Pause, Game Over, Reward UI | Developer | 3–5 days |
| **Gameplay** | Mechanic prototype, sound, effects, first level | Developer | 5–10 days |
| **Content** | 20 levels → 100–200 levels | Developer | 5–10 days |
| **QA & Store** | Testing, store listing, submission | QA & Developer | 1–2 days |

> **Game Design:** ~1–3 days  
> **Art & Design:** ~3–5 days  
> **Develop + QA:** ~17–32 days  
> **Total: ~21–40 days** (~3–8 weeks) for a 2-person team.  
> Art and level design can run in parallel with development to shorten the timeline.

---

## 5. Key Challenges

1. **Level design** — every level must be manually played and tested; very time-consuming
2. **Slide feel** — smooth snap, swipe gestures, no ghost inputs
3. **Economy balance** — too easy to earn coins hurts revenue; too hard causes uninstalls
