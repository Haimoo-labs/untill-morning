# MVP Fast Track -suunnitelma — Until Morning Prototype v0.1

## Status

Active. Laatija: Gantt (projektipäällikkö). Päivä: 2026-07-07.

## Tarkoitus

Tämä on tiukka ja nopea etenemissuunnitelma yhdelle toteuttajalle (agentti tai kehittäjä)
kohti Miranda-portin **Portti 1 = "v0.1 on pelattava"** läpäisyä. Tavoite ei ole valmis
peli vaan **todennettavasti pelattava kolmen yön luuppi Godotissa**. Ei uutta scopea,
ei kauneutta, ei "do not build" -listan ominaisuuksia.

Kanoniset lähteet joita tämä suunnitelma ei muuta:
`docs/tasks/CLAUDE-CODE-TASKS-v0.1.md`, `docs/prototype-v0.1/*`,
`docs/quality/DEFINITION-OF-DONE.md`, `docs/business/PRODUCTIZATION-ROADMAP.md`,
`docs/product/BACKLOG.md`.

## Lähtötila (todennettu 2026-07-07)

- `game/scripts/core/game_state.gd`: ~25 riviä. On: day, food, wood, ammo, gate_hp,
  last_report, reset(), is_prototype_complete(). **Puuttuu:** Phase-enum, expedition-,
  night- ja repair-tuloskentät, status-kentät, ja 7 vaadittua metodia
  (run_forest_expedition, continue_to_evening, repair_gate, start_night,
  continue_after_night, start_next_day + korjattu reset).
- `game/scripts/ui/main_controller.gd`: 7 riviä, tyhjä stub (vain print).
- `game/scenes/main/main.tscn`: olemassa, on main_scene.
- `game/project.godot`: autoload `GameState` konfiguroitu, `config/features="4.3"`,
  pystyorientaatio 720x1280 mobiili. Kunnossa.
- **Godot-binääriä EI ole tässä ympäristössä** (`which godot` = ei löydy). Tämä on
  kriittisin este, ks. Riski R1.

Käytännössä Task 001 ja siitä eteenpäin ovat kaikki vielä tekemättä.

---

## 1. Tehtävät järjestyksessä ja riippuvuudet

| # | Tehtävä | Riippuu | Tuotos | Kriittisellä polulla |
|---|---|---|---|---|
| 001 | Laajenna GameState | — | game_state.gd: kentät, enum, 7 metodia | **Kyllä** |
| 002 | Single-scene UI phase renderer | 001 | main_controller.gd + main.tscn: 7 vaihetta, napit, uudelleenpiirto | **Kyllä** |
| 003 | Manuaalinen testiajo (TC-001…010) | 002 + Godot-ympäristö | testitulokset pass/fail | **Kyllä** (Portti 1 vaatii ajon) |
| 004 | Balanssiajo | 002 (käytännössä 003 rinnalla) | vahvistetut/tuunatut arvot, BALANCE-TABLE ajan tasalla | Ei (tuunaus) |
| 005 | v0.1 completion report | 003 + 004 | change report, Portti 1 -verdikti | Ei (raportointi) |

Riippuvuusketju lyhyesti: **001 → 002 → 003 → 005**. 004 nojaa 002:een ja limittyy
003:n kanssa (sama pelattava build). 005 kokoaa 003:n ja 004:n tulokset.

Ainoa ulkoinen riippuvuus koko polulla on **toimiva Godot 4.3 -ympäristö + ihminen
joka klikkaa testit läpi** (Task 003). Se ei ole koodiriippuvuus vaan
ympäristöriippuvuus, ja siksi suurin aikatauluriski (R1).

---

## 2. Kriittinen polku ja mitä voi lykätä

**Lyhin reitti tilaan "peli on käynnistettävissä ja pelattavissa yhdeltä ihmiseltä
Godotissa":**

> **Task 001 (GameState) → Task 002 (renderer) → avaa `game/project.godot`, aja main-scene.**

Tämän jälkeen luuppi on ajettavissa. Kaikki muu on verifiointia, tuunausta ja
raportointia sen päällä.

Mitä EI voi lykätä (kuuluu 001+002:een):
- Kaikki 7 vaihetta, myös **Game Over** ja **Prototype Complete**. SCENE-FLOW ja
  blueprint ehdottavat ne "viimeisenä" toteutusjärjestyksessä, mutta DoD R2 ja Portti
  1 (TC-009, TC-010) vaativat molemmat renderöityvän. Ne siis rakennetaan Task 002:n
  **loppuosassa**, ei erillisenä myöhempänä taskina. Lykkääminen kaataisi Portti 1:n.

Mitä voi tehdä rinnakkain tai limittää (ei pidennä kriittistä polkua):
- **Godot-ympäristön pystytys** (R1-mitigointi) kannattaa aloittaa **heti 001:n
  rinnalla**, jotta se ei odota valmista koodia ja jotta Task 003 ei blokkaudu.
- **Task 004 (balanssi)** limittyy Task 003:n manuaaliajon kanssa: arvot ovat jo
  BALANCE-TABLE:ssa, joten 004 on lähinnä "vahvista pelatessa" + pieni tuunaus.

Mitä voi lykätä ilman että Portti 1 vaarantuu:
- **Task 005 completion report** on aidosti viimeinen, riippuu 003+004:n tuloksista.
- Mikä tahansa visuaalinen viimeistely, ääni, animaatio, tallennus: kielletty v0.1:ssä
  joka tapauksessa (BACKLOG "Do not build").

---

## 3. Aikaboksit (yksi toteuttaja, tunteina)

Arviot ovat yhden agentin/kehittäjän työtä, eivät tiimin. Työ on determinististä:
spec antaa kentät, metodit, kaavat ja balanssiarvot valmiina, mikä pienentää arviota.

| # | Tehtävä | Aikaboksi | Peruste |
|---|---|---:|---|
| 001 | Laajenna GameState | 3–4 h | ~20 uutta kenttää + enum + 7 pientä metodia, kaikki spec:ssä valmiina; kaavat suoraan BALANCE-TABLE:sta |
| 002 | Single-scene renderer | 6–9 h | Suurin osa työstä: 7 vaihetta, napit, uudelleenpiirto; blueprint kieltää polishin joten ei UI-hienosäätöä |
| 003 | Manuaalinen testiajo | 2–3 h | TC-001…010 klikkaus + fix vain pieniin blokkereihin — **edellyttää toimivaa Godotia** |
| 004 | Balanssiajo | 1–2 h | Arvot jo taulukossa; vahvista pelatessa, tuunaa vain jos Day-käyrä ei toteudu |
| 005 | Completion report | 1–2 h | Templaattipohjainen kooste 003+004:stä |

**Kriittinen polku pelattavaan buildiin (001+002): ~9–13 h.**
**Koko polku Portti 1:een (001–005): ~13–20 h puhdasta työtä.**

Puskuri: lisää **+30 %** epävarmuudelle (Godot-ajon ensiyllätykset, UI-uudelleenpiirron
kitka, tuntematon ympäristön pystytysaika) → realistinen **~18–26 h** kalenterityönä,
kun Godot-ympäristö on saatavilla. Jos ympäristön pystytys lasketaan mukaan, lisää sen
oma erillinen aika (R1). Roadmapin R-P1-luku ~40–80 h kattaa laajemman iteroinnin ja
ympäristön; tämä nopea polku on tarkoituksella tiukempi, mutta ei valehtele
verifiointikustannuksesta.

---

## 4. Kolme suurinta riskiä tälle nopealle polulle

### R1 — Godot-ympäristö puuttuu (KORKEA, kriittisellä polulla)

`which godot` ei löydä binääriä. Portti 1 kieltää **eksplisiittisesti** luupin osalta
"not tested" -tilan: TC-001…010 on oltava **pass oikealla Godot-ajolla**. Ilman
toimivaa Godot 4.3:a ja ihmistä joka klikkaa testit, "toimii" on katteeton eikä Porttia
1 voi julistaa läpi, vaikka koodi (001+002) olisi valmis. Tämä on sama kuin roadmapin
R-P3.

Mitigointi:
- Pystytä **Godot 4.3** (vastaa `config/features="4.3"`) heti, **rinnan Task 001:n
  kanssa**, ettei se odota valmista koodia.
- Headless-ajolla (`godot --headless --script ...`) voi tarkistaa että game_state.gd
  **parsii** ja metodit ajautuvat ilman UI:ta jo Task 001:n jälkeen — halpa aikainen
  varmistus.
- TC-002…010 vaatii kuitenkin näkyvän UI:n klikkauksen. Varmista **nimetty ihminen tai
  editor-istunto** joka ajaa manuaaliajon Task 003:ssa. Jos tätä ei saada, Portti 1 on
  blokattu — nostettava omistajalle heti, ei Task 003:n takarajalla.

### R2 — Single-scene rendererin UI-vaatimus tulkinnanvarainen (KESKI, kriittisellä polulla)

SCENE-FLOW antaa vaiheiden vastuut mutta ei tarkkaa node-layoutia ("rebuilds simple UI
based on phase"). Riski: joko ali-toteutus (nappi puuttuu, testi feilaa) tai
yli-insinöörointi (signaaliarkkitehtuuri, erilliset scenet) joka syö aikaboksin.

Mitigointi:
- Noudata SCENE-FLOW:n suositusta orjallisesti: yksi root `Control`,
  `main_controller.gd` rakentaa placeholder-tekstin + napit vaiheen mukaan, napit
  kutsuvat GameState-metodia ja re-renderöivät. Ei nested scenejä, ei animaatioita
  logiikkana, ei per-systeemi managereita (blueprint kieltää nämä).
- Käytä TEST-PLANin TC-001…010 nappi/näkymä-listaa toteutuksen tarkistuslistana:
  jokainen vaihe näyttää spec:n kentät ja tarjoaa spec:n napit, ei enempää.

### R3 — Scope creep "nopeuden" nimissä (KESKI)

Aikapaine houkuttaa lisäämään: nälkäkuolema (food), ekstra loot-logiikka, useampi
paikka, animaatiot. CLAUDE.md, blueprint ja BACKLOG "Do not build" kieltävät nämä.
Erityinen ansa: food-käyttäytyminen v0.1:ssä on **vain** "kuluta 1/yö + varoitusteksti
0:ssa", EI starvation-kuolemaa.

Mitigointi:
- Task-per-task -kuri: yksi taski kerrallaan, jokainen taski **raportoi scope creepin**
  (DoD:n completion-report -pohja pakottaa tämän).
- Katselmoija/QA-portti ennen kuin taski katsotaan valmiiksi; scope-validointilista on
  valmiina TEST-PLANissa ja GAME-STATE-SPECissä ("Do not add these fields").

---

## 5. Seuraava konkreettinen toimenpide

Heti kun käyttäjä antaa luvan, käynnistä **kaksi asiaa rinnan**:

1. **Toteutus — aloita Task 001.** Anna toteuttajalle (backend/toteutusagentti)
   `docs/tasks/CLAUDE-CODE-TASKS-v0.1.md`:n Task 001 -lohko sellaisenaan (copy-paste).
   Kohde: vain `game/scripts/core/game_state.gd`. Valmis kun kaikki GAME-STATE-SPEC:n
   kentät, Phase-enum ja 7 metodia ovat paikallaan ja skripti parsii.

2. **Ympäristö — provisioi Godot 4.3 (R1-mitigointi).** Aloita heti, älä odota Task
   001:n valmistumista. Kun binääri on, varmista headless-parse:
   `godot --headless --path game --check-only` (tai vastaava) game_state.gd:lle Task
   001:n jälkeen. Sovi kuka klikkaa TC-001…010 Task 003:ssa.

Kun 001 on hyväksytty, siirry suoraan Task 002:een (renderer). Älä avaa 003:a ennen
kuin Godot-ympäristö on todistetusti toiminnassa.

---

## Portti 1 -läpäisyn muistilista (Task 005:ssä kuitattava)

- [ ] Task 001–005 valmiit
- [ ] TC-001…TC-010 = **pass** oikealla Godot-ajolla (ei "not tested" luupin osalta)
- [ ] DoD R2:n Prototype v0.1 -tarkistukset kaikki tosi
- [ ] BACKLOG "Now" -lista katettu, "Do not build" kunnioitettu (ei scope creepiä)
- [ ] Ydinvalinta "käytänkö resurssit nyt vai riskeeraanko yön?" pelattavissa
- [ ] Verdikti kirjattu: tagataanko `prototype-v0.1.0`
