# Balance Tuning Recommendation — Prototype v0.1

Author: Ludo (pelisuunnittelija)
Status: Recommendation only. Not implemented. Requires approval before touching `game/` or `BALANCE-TABLE.md`.
Basis: 2000–3000 automated playthroughs per config, simulating the exact `game_state.gd` logic (expedition loot RNG, auto-ammo, repair, night resolution). Simulator lives in scratchpad, not in the repo.

---

## 1. Diagnosis: confirmed, but the root cause is not the ammo cap

Task 004 found 100% wins on both `never_repair` and `always_repair`. My simulation reproduces this exactly (never_repair 100%, floor gate 30; always_repair 100%, floor 40). The finding is real.

But I challenge the stated root cause. The claim was that `MAX_AMMO_AUTO_USED_PER_NIGHT = 3` is why the player cannot lose. It is not. That cap **limits** mitigation — raising it would help the player *more*, not less. The player survives *despite* the cap, not because of it.

The actual root cause is a **compound of three factors**:

1. **Raw damage barely exceeds gate HP.** Total night damage is 25+40+60 = **125** against a **100 HP** gate. Even with *zero* defense the margin is only 25. A 3-night wall that is nearly tall enough on its own leaves almost no room for any mitigation before it becomes unlosable.
2. **Ammo mitigation is cheap, large, and automatic.** Up to 30 blocked damage per night (90 over the run) against a 25-point deficit. The player starts with 6 ammo and loot tops it up ~1/day, so the cap is almost always reachable. Automatic mitigation this large trivially erases the thin deficit.
3. **Repair is the *only* real decision, and it is not required.** Ammo is auto-consumed — the player never chooses it, so "ammo state" is pure loot RNG, not skill. The single lever the player actually pulls is **repair** (spend wood). Because raw damage can't kill even without repair, that lever has no teeth.

**Consequence for the product criteria.** Miranda's Portti 2 asks that a loss be *attributed to the player's own choice*. In v0.1 the only choice is repair. Therefore the fix must make **the repair decision the pivot between winning and losing.** The design also has to keep the product feeling — *"I survived barely. One more day."* — which means the *winning* path should end with a low gate, not a comfortable one.

Empirical proof the cap is not the lever: raising night damage to 30/55/85 while keeping cap 3 / ammo 6 still leaves `never_repair` at **90% wins**. Carelessness is not punished until ammo mitigation itself is weakened.

---

## 2. Design goal restated as measurable targets

From BALANCE-TABLE.md + the product rule, a good tune must hit all of:

- **Day 1** deals a small, visible hit — player learns the gate can be hurt. (easy intro)
- **Day 2** deals a clearly larger hit that prompts the first repair. (resources feel limited)
- **Day 3** is **lethal if the player ignored repair**, survivable if they engaged. (win or lose depending on repair state)
- A player who repairs survives with a **low** gate (roughly 10–40 of 100), not a full one. ("barely")
- `never_repair` should **not** reliably win.

---

## 3. Recommended change (primary)

Change three constants in `game_state.gd` (values below; do **not** edit yet):

| Constant | Current | Proposed | Reason |
|---|---:|---:|---|
| `NIGHT_DAMAGE_BY_DAY` | 25 / 40 / 60 | **30 / 50 / 80** | Raw damage must overwhelm the (now weaker) automatic mitigation so the repair lever matters. Day 3 at 80 is lethal without repair. |
| `MAX_AMMO_AUTO_USED_PER_NIGHT` | 3 | **2** | Caps automatic mitigation at 20/night regardless of loot luck, so days 2–3 actually bite. This is the key lever that makes carelessness losable. |
| `STARTING_AMMO` | 6 | **4** | Lets ammo run short by day 3 and thins the winning margin from ~20 to ~10 ("barely"). Optional — see §5. |

Everything else stays: gate 100, repair +20 per 1 wood, block 10/ammo, wood 3, food 3, loot table unchanged.

### Simulated outcome (3000 runs)

| Strategy | Win % | Final gate (min/avg/max) |
|---|---:|---|
| `never_repair` | **0%** — dies night 3 every time | — |
| `frugal` (repair only what the night needs) | 100% | **10 / 19 / 20** |
| `panic` (top the gate to full every evening) | 100% | 20 / 39 / 40 |

This hits every target:

- **Day 1:** 30 incoming − 20 blocked = **10** to the gate. Gentle first scratch.
- **Day 2:** 50 − 20 = **30** to the gate (down to ~60). The first real hit — this is where the player reaches for the repair button.
- **Day 3:** 80 incoming. No repair → gate dies. Repair → survive at **10–40 HP**. Exactly *"I barely made it."*
- Loss is **100% attributable to the repair choice**, satisfying Portti 2 cleanly — a player who ignores the gate always dies, a player who engages always lives.
- Winning gate is low, satisfying the product rule.

Day 1 must be **30, not 25**: at 25 the cumulative damage drops enough that `never_repair` survives ~90% of the time on day-3 ammo luck, which breaks the "your fault" attribution. 30 is what makes the deterministic punishment hold.

---

## 4. Alternatives considered

Three risk levels. I recommend the middle (§3).

### Option MIN — smallest change (lower risk)
Change only `NIGHT_DAMAGE_BY_DAY → 30/50/80` and `MAX_AMMO_AUTO_USED_PER_NIGHT → 2`. Leave starting ammo at 6.
- Result: `never_repair` **0%**, `frugal` survives at a flat **20**, `panic` at 40.
- Achieves the core goal (carelessness = death, repair = survival) with two constants instead of three.
- Downside: the winning margin is a flat 20 with no texture — ammo never runs short, so day 3 has no "I'm nearly out" beat. Slightly less "barely."

### Option REC — recommended (see §3)
As above. Adds `STARTING_AMMO → 4`. Thinner winning margin (10–20), ammo can run short on day 3. Best fit for both product criteria at a cost of one extra constant. **This is my pick.**

### Option SOFT — day-3 luck tension (higher design risk)
Keep cap 3 and ammo 6, weaken ammo to **8 blocked/ammo**, raise damage to **30/55/85**.
- Result: `never_repair` **66% wins**, repairers scrape to as low as **2 HP** — extremely tense finishes.
- Why I recommend *against* it: it buys knife-edge day-3 drama by making the *outcome depend on loot RNG*, which means a careless `never_repair` player still wins two-thirds of the time. That directly violates Portti 2 — the loss is attributed to luck, not the player's choice. Good drama, wrong attribution for v0.1.

---

## 5. Notes for implementation (later, after approval)

- These are three (or two, for MIN) constant edits in `game/scripts/core/game_state.gd`. No new fields, systems, or methods. Fully inside v0.1 scope — no infection, weather, NPC, or ammo-choice mechanic is introduced.
- `BALANCE-TABLE.md` must be updated to match in the same change so the doc stays canonical (night damage row, ammo mitigation row, starting ammo).
- The one structural limitation worth flagging upward, but **out of scope for v0.1**: ammo is auto-consumed, so it can never be a *skill* lever — only repair is. If a future version wants "manage your ammo" to be a real decision (and to let ammo, not just repair, decide the night), that needs a mechanic where the player chooses ammo spend. Do **not** add it now; note it for the post-prototype roadmap.

---

## 6. Validation status

Playtested in simulation only (logic-faithful, 3000 runs/config), not yet in the running Godot build. Per the design quality gate, "fun" is not proven until it is played. The numbers here make losing *possible and choice-driven*, which is a necessary condition for the intended feeling — but the actual "one more day" tension must be confirmed in a real play pass (Task 003 / a follow-up balance playtest) before this is called done.
