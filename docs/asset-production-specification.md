# Asset Production Specification — Until Morning

> Status: **v0.1 asset production spec** · Owner role: **Frida (art direction / visual design system / asset production lead)**
> Companion to `docs/game-design-document.md`. Last updated: 2026-07-07
> This document defines **how assets are produced**. It is not an integration task, contains no code, and does not put assets into the game.

---

## 1. Purpose

- Tämä dokumentti **määrittää assettien tuotannon** Until Morning -pelille: mitä tehdään, missä perspektiivissä, millä paletilla, missä koossa ja millä hyväksymiskriteereillä.
- Tämä **ei ole assettien integraatiotask.** Assetteja ei viedä peliin tämän dokumentin perusteella.
- Tämä **ei sisällä koodia.** Ei Sprite2D-, TileMap- eikä HUD-integraatiota, ei scene-muutoksia.
- Tämä **ohjaa** kolmea myöhempää työvaihetta: (1) AI-kuvagenerointi (referenssit), (2) käsin tehtävä pixel art, (3) Godot-integraatio myöhemmin.
- Perusta: `docs/game-design-document.md` §17 Art Direction Summary. Jos tämä ja GDD ovat ristiriidassa, **GDD:n art direction voittaa.**

---

## 2. Global Asset Rules

Nämä säännöt koskevat **kaikkia** lopullisia peliassetteja:

- **2D top-down / 3/4 yläviisto** — aina.
- **pixel art** — aina.
- **rajattu paletti** — vain §5:n kuusi väriä (+ läpinäkyvyys).
- **transparent PNG** kaikille spriteille ja objekteille.
- **tilet neliönä** — saumattomasti toistuvia.
- **32×32 base tile.**
- **32×48 hahmo** tarvittaessa (kun pysty korkeutta tarvitaan luettavuuteen).
- **Nearest-filter Godotissa** (integraatiovaiheessa).
- **ei antialiasointia** lopullisiin spriteihin.
- **ei tekstiä** assettikuviin (ei labeleita, ei watermarkkeja, ei mittoja kuvan sisään).
- **ei isoja konseptisivuja** lopullisina asseteina — yksi asset per tiedosto (tai siisti spritesheet ilman tekstiä).

---

## 3. Perspective Rules

- **Hahmot näkyvät ylhäältä / 3/4 yläviistosta.** Lukittu.
- **Ei sivulta** (no side view).
- **Ei muotokuvaa** (no portrait / no frontal face shot).
- Hahmo luetaan **päälaen, hartialinjan, repun, aseen, vaatteen väriblokkien ja siluetin** kautta — ei kasvoista.
- **Portti** on **top-down este-nauha** pelialueen reunalla — ei sivuprofiili-porttia.
- **Base** on **pieni top-down pelialue** portin takana.
- **Tilejen pitää toistua saumattomasti** (seamless tiling) joka suuntaan, missä sitä tarvitaan.

---

## 4. Character Age Rules

Tämä on kriittinen ja aiemmin väärin mennyt kohta. Lukittu:

- päähahmo on **oikeasti nuori** — myöhäisteini tai hyvin nuori aikuinen.
- **ei keski-ikäinen.**
- **ei "nuorelta näyttävä aikuinen".**
- **ei sankarillinen nuori sotilas.**
- **pieni koko suhteessa aseeseen ja takkiin** — mittakaava kertoo iän: iso takki/huppari, iso ase, pieni keho.
- **haavoittuva mutta toimintakykyinen** — ei avuton, ei supersankari.
- **pieni itse korjattu reppu** — kotitekoinen, väärän kokoinen.
- **vältä liian lapsellista / chibi-ilmettä** — ei suuria söpöjä päitä, ei vauvamaisia mittasuhteita.
- **vältä söpöyttä** — hahmo on väsynyt ja kireä, ei viehättävä.

> Nuoruus välitetään **mittakaavalla ja siluetilla top-down-näkymässä**, ei kasvoilla. Turvallisuussyistä (ks. GDD §23): abstrakti/hidas uhka, ei gorea, ei lähikuvia. Assetit eivät kuvaa väkivaltaa hahmoa kohtaan.

---

## 5. Palette

Kaikki assetit käyttävät vain näitä kuutta väriä (+ täysi läpinäkyvyys). Sävyjä voi ditheröidä pikselitasolla, mutta uusia värejä ei lisätä.

| Hex | Rooli | Käyttösääntö |
|---|---|---|
| `#151515` | perusvarjo / yö / ääriviivat | outline ja syvin varjo |
| `#f2c166` | **lämmin valo / toivo / nuotio / aamunkoitto** | **vain valolle ja toivolle — EI koskaan uhkaan** |
| `#30382f` | tumma oliivi / maasto / kulunut kangas | maasto, vaatteet, ympäristö |
| `#8a8f87` | kylmä harmaa / päivävalo / iho / kuolleet sävyt | neutraali/kylmä perusväri, iho, päivä |
| `#9aa64a` | sairaalloinen keltavihreä | **vain tartuttajazombi (infector) — ei mitään muuta** |
| `#5c2e1f` | ruoste / tumma vaurio | hyvin hillitty uhka-/vauriokorostus |

> **Ehdoton värisääntö:** lämmin `#f2c166` = valo/toivo (nuotio, aamu, turva). Sitä **ei käytetä uhkaan.** Uhka on kylmää, harmaata, ruosteista tai (vain infector) sairaan keltavihreää.

---

## 6. Folder Structure

Ehdotettu hakemistorakenne. **Tämä on dokumentaatio — älä luo tiedostoja tässä tehtävässä.** Kansiot syntyvät vasta, kun asseteja oikeasti tuotetaan.

```
game/assets/
├── sprites/
│   ├── player/        # young survivor
│   ├── enemies/       # slow zombie, (myöh.) infector
│   └── npcs/          # (v0.5) trader, nurse
├── tiles/
│   ├── base/          # leiri/camp lattiatilet
│   ├── forest/        # metsätilet
│   └── pharmacy/      # (v0.2) apteekkitilet
├── objects/
│   ├── gate/          # portti (intact/damaged/near-broken)
│   └── camp/          # nuotio, tarvikkeet, leiriobjektit
├── icons/
│   ├── resources/     # food, wood, ammo, (myöh.) medicine, metal
│   └── ui/            # gate health, day/night, action-ikonit
├── effects/           # partikkelit, valot, (myöh.) sää/yöefektit
└── references/        # AI-referenssit ja moodboardit (EI peliassetteja)
```

> **`references/` on eristetty:** sinne menevät AI-kuvat ja moodboardit, joita **ei viedä peliin** sellaisenaan. Peliassetit ovat vain muissa kansioissa jälkikäsittelyn jälkeen.

---

## 7. Naming Convention

Muoto: pienet kirjaimet, alaviivat, kuvaava ja koneellisesti lajiteltava. Rakenne:
`<tyyppi>_<aihe>_<toiminto/tila>_<suunta>_<frame>.png`

- suunnat (kun relevantti): `down`, `up`, `left`, `right` (top-down 4-suunta)
- animaatioframet: `_01`, `_02`, …
- tilat: `_intact`, `_damaged`, `_near_broken`, `_idle`, `_walk`

Esimerkkejä:
- `player_young_survivor_idle_down.png`
- `player_young_survivor_walk_down_01.png`
- `enemy_slow_zombie_idle_down.png`
- `enemy_slow_zombie_walk_down_01.png`
- `object_gate_intact.png`
- `object_gate_damaged.png`
- `tile_base_ground_01.png`
- `tile_forest_ground_01.png`
- `icon_resource_food.png`
- `icon_resource_wood.png`
- `icon_resource_ammo.png`
- `icon_gate_health_intact.png`
- `icon_gate_health_damaged.png`

---

## 8. v0.1 Required Asset List

Nämä ovat **pakollisia** v0.1:lle (GDD §6). Koko on suunnittelun lähtökohta; lopullinen koko voi tarkentua Godot-testissä.

| Asset | Purpose | Suggested size | Background | Perspective | Animation needed | Acceptance criteria | Priority |
|---|---|---|---|---|---|---|---|
| Young survivor — idle (down) | pelaajahahmon perustila | 32×48 | transparent | top-down 3/4 | ei (1 frame) | oikeasti nuori; iso takki + iso ase + pieni reppu; kapea siluetti; luettava 32px:ssä | P0 |
| Young survivor — walk cycle (basic, down) | pelaajan liike | 32×48 | transparent | top-down 3/4 | kyllä (2–4 framea) | selkeä kävelyrytmi; siluetti pysyy nuorena; ei sankariposea | P0 |
| Slow zombie — idle (down) | vihollisen perustila | 32×48 | transparent | top-down 3/4 | ei (1 frame) | hidas massa; entinen ihminen; kylmät värit; ei lämmintä `#f2c166` | P0 |
| Slow zombie — walk cycle (basic, down) | vihollisen liike | 32×48 | transparent | top-down 3/4 | kyllä (2–4 framea) | raskas, hidas liike; luettava siluetti; ei splatteria | P0 |
| Intact gate | portti ehjänä | 64×32 (tai 2×1 tile) | transparent | top-down este-nauha | ei | luetaan tiiviinä esteviivana ilman numeroita | P0 |
| Damaged gate | portti vaurioituneena | 64×32 | transparent | top-down este-nauha | ei | selvät halkeamat/raot; sama muoto kuin intact | P0 |
| Base ground tile | leirin lattia | 32×32 | opaque (tile) | top-down | ei | saumaton toisto; kylmä/niukka; ei kuvioita jotka toistuvat silmiinpistävästi | P0 |
| Forest ground tile | metsän lattia | 32×32 | opaque (tile) | top-down | ei | saumaton toisto; harmaa/kylmä metsä, ei satumetsä | P0 |
| Camp supplies object | leirin niukkuus-objekti | 32×32 | transparent | top-down 3/4 | ei | improvisoitu, väliaikainen; kertoo niukkuudesta | P1 |
| Campfire | ainoa lämpö/toivo | 32×32 | transparent | top-down 3/4 | kyllä (2–3 framea, liekki) | `#f2c166`-valo; ainoa lämmin elementti; luettava yöllä | P0 |
| Food icon | resurssi-ikoni | 16×16 tai 32×32 | transparent | ikoninen | ei | luettava HUD-koossa; ei tekstiä | P0 |
| Wood icon | resurssi-ikoni | 16×16 tai 32×32 | transparent | ikoninen | ei | luettava HUD-koossa; ei tekstiä | P0 |
| Ammo icon | resurssi-ikoni | 16×16 tai 32×32 | transparent | ikoninen | ei | luettava HUD-koossa; ei tekstiä | P0 |
| Gate health — intact icon | portin kunto HUD | 16×16 tai 32×32 | transparent | ikoninen | ei | selkeästi "ehjä"; erottuu damaged-ikonista | P1 |
| Gate health — damaged icon | portin kunto HUD | 16×16 tai 32×32 | transparent | ikoninen | ei | selkeästi "vaurioitunut"; erottuu intact-ikonista | P1 |

> **Suuntamäärä v0.1:** aloita `down`-suunnasta (kohti pelaajaa). 4-suuntainen (up/left/right) voidaan lisätä samalla lukolla, kun down on hyväksytty. Älä tee kaikkia suuntia ennen kuin yksi on validoitu.

---

## 9. v0.2 Asset List *(tuleva scope — ei tuoteta v0.1:ssä)*

- infector (tartuttajazombi) — idle + walk, top-down; erottuu siluetilla + `#9aa64a`
- medicine icon
- pharmacy floor tile
- infection UI indicator

---

## 10. v0.3 Asset List *(tuleva scope — ei tuoteta v0.1:ssä)*

- backpack icon
- backpack slot UI -elementit
- metal icon
- hardware store floor/object tiles

---

## 11. v0.5 Asset List *(tuleva scope — ei tuoteta v0.1:ssä)*

- trader (top-down NPC)
- nurse (top-down NPC)
- simple trade UI -elementit (ei dialogipuu-UI:ta)

---

## 12. Future / Speculative Asset List *(spekulatiivinen — ei hyväksytty scope)*

- runner (ryntääjä)
- breaker / murtaja
- weather effects
- extra night effects
- UI polish -assetit

> **Merkintä:** nämä ovat ideoita. Ei tuoteta eikä käsitellä hyväksyttynä scopena ilman GDD-/backlog-päivitystä.

---

## 13. AI Image Generation Rules

AI-kuvat ovat **referenssejä ja lähtömateriaalia**, eivät automaattisesti lopullisia spritejä.

- **generoi mieluiten yksi asset-tyyppi kerrallaan** (esim. pelkkä young survivor idle), ei sekasheettiä.
- **älä generoi isoa sheettiä jossa on tekstiä**, labeleita tai mittoja.
- **älä hyväksy kuvaa jos se on frontaalinen / sivusta.**
- **älä hyväksy kuvaa jos päähahmo näyttää aikuiselta.**
- **älä hyväksy kuvaa jos se on maalauksellinen** eikä pixel art -suuntainen.
- **käytä AI-kuvia tarvittaessa referenssinä, mutta tee aina pixel-grid-jälkikäsittely** (§14) ennen kuin mitään pidetään peliassettina.
- tallenna AI-kuvat `game/assets/references/`-kansioon, ei suoraan sprite-/tile-kansioihin.

**Yhteinen prompt-etuliite (englanniksi — käytä jokaisen asset-promptin alussa):**

```
2D top-down 3/4 overhead pixel art game asset, clean pixel grid, limited muted
palette (#151515 shadow/outline, #f2c166 warm light ONLY, #30382f dark olive,
#8a8f87 cold grey, #5c2e1f rust), transparent background, strong readable
silhouette at small size, no antialiasing, no text, no labels, no UI frame,
no heroic pose, no cute chibi style. NOT side view, NOT portrait, NOT painterly.
For the player character: a TRUE YOUNG survivor (late teen / very young adult),
small and narrow body, oversized coat/hoodie, oversized weapon, small
self-repaired backpack — NOT an adult, NOT a soldier, NOT a hero. Read the
character from above by silhouette, gear and color blocks, not by face.
Then, per asset:
```

> Lisää tämän etuliitteen perään yksi asset kerrallaan (esim. `... slow zombie, slow heavy mass, former ordinary person, cold decayed tones, walk-down frames`).

---

## 14. Pixel Cleanup / Post-processing

Jokainen referenssistä johdettu tai käsin tehty asset käy tämän läpi ennen "peliassetti"-statusta:

1. **pienennys oikeaan kokoon** — skaalaa alas kohde­kokoon (32×32 / 32×48 / ikoni) hallitusti, ei sumeasti.
2. **palette quantization** — pakota §5:n kuuteen väriin (+ alpha); poista vieraat sävyt.
3. **käsin siivous** — korjaa pikselit, outline, muoto ja luettavuus käsin (Aseprite tms.).
4. **läpinäkyvyyden tarkistus** — täysin läpinäkyvä tausta, ei puoliläpinäkyviä reunahaloja.
5. **outline check** — johdonmukainen ääriviiva (`#151515`), ei rikkinäisiä reunoja.
6. **luettavuus 1×, 2× ja mobiilikoossa** — tarkista, että asset toimii natiivikoossa, tuplattuna ja oikealla mobiilinäytöllä.

---

## 15. Godot Import Notes

*(Ei toteuteta tässä tehtävässä — ohje myöhempää integraatiota varten.)*

- **filter: Nearest** (ei lineaarista suodatusta) — säilyttää terävät pikselit.
- **mipmaps: off.**
- **repeat: tiles vain tileille**, jos saumaton toisto tarvitaan; muut assetit ei-toistuvia.
- **texture compression** huomioitava mobiilissa — vältä artefaktoivaa pakkausta pikselitaiteessa (harkitse pakkaamatonta/lossless pikselisheeteille).
- **pidä originaalit ja peliversiot erillään** — lähdetiedostot (esim. `.aseprite`) ja `references/` erillään peliin vietävistä PNG:istä.
- **älä skaalaa suttuisesti** — käytä vain kokonaislukukertoimia (1×, 2×, 3×), ei murtolukuja.

---

## 16. Acceptance Checklist

Jokaisen assetin pitää läpäistä **kaikki**. Yksikin "väärin" = hylkää ja korjaa.

- [ ] onko top-down / 3/4 yläviisto?
- [ ] onko pixel art?
- [ ] onko oikea paletti (vain §5:n värit)?
- [ ] onko sprite luettava pienessä koossa (1×)?
- [ ] onko tausta läpinäkyvä (spriteille/objekteille)?
- [ ] onko päähahmo oikeasti nuori (ei aikuinen, ei "nuorelta näyttävä aikuinen")?
- [ ] onko assetissa tekstiä? → **jos on, hylkää.**
- [ ] näyttääkö se sankarilta / sankariposelta? → **jos kyllä, hylkää.**
- [ ] näyttääkö se sivuprofiililta tai frontaalimuotokuvalta? → **jos kyllä, hylkää.**
- [ ] käytetäänkö lämmintä `#f2c166`-väriä uhkaan? → **jos kyllä, hylkää.**
- [ ] voiko sen käyttää Godotissa ilman suurta korjausta?

---

## 17. First Production Batch

Ensimmäinen järkevä tuotantoerä (referenssit + pixel-jälkikäsittely, **ei peliin vientiä**). Järjestys on prioriteetti:

1. **player idle down** — lukitsee hahmon iän, mittakaavan ja siluetin (kaiken perusta).
2. **player walk down (basic)** — vahvistaa liikkeen ja luettavuuden.
3. **slow zombie walk down** — lukitsee vihollisen luettavuuden ja kylmän palettin.
4. **intact gate** — pelin sydän, ehjä tila.
5. **damaged gate** — sama muoto vaurioituneena (tilaparille johdonmukaisuus).
6. **base ground tile** — leirin saumaton pohja.
7. **forest ground tile** — metsän saumaton pohja.
8. **food / wood / ammo icons** — HUD-luettavuus pienessä koossa.
9. **campfire** — ainoa lämmin `#f2c166`-elementti, animoitu liekki.
10. **gate health icon** — portin kunnon HUD-indikaattori (intact/damaged).

> Validoi erä 1 (player idle down) **ennen** kuin tuotat muita hahmoja tai muita suuntia. Yksi hyväksytty hahmolukko säästää koko tuotannon uudelleentyöltä.

---

## Source coverage

**Luetut tiedostot:** ei mitään — projektissa ei ollut yhtään tiedostoa dokumentin luontihetkellä (2026-07-07). Perustuu kokonaan tehtävänannon art direction-, paletti-, hahmo-, perspektiivi- ja scope-päätöksiin sekä companion-dokumenttiin `docs/game-design-document.md`.

## Missing sources

Kaikki odotetut lähteet puuttuivat:
- `CLAUDE.md`
- `docs/game-design-blueprint.md`
- `docs/mvp-scope.md`
- `docs/product/BACKLOG.md`
- `docs/product/FEATURE-PARKING-LOT.md`
- `docs/business/FEELS-LIKE-A-GAME-MILESTONE.md`
- `docs/business/CHARACTER-ROSTER.md`
- `docs/business/ARTDIRECTION-ASSETPACK.md`
- `game/project.godot`
- nykyiset Godot-scriptit ja scene-tiedostot

> Kun `ARTDIRECTION-ASSETPACK.md` ja `CHARACTER-ROSTER.md` ilmestyvät, tämä spec pitää sovittaa niihin. Ristiriidat ratkaistaan uuden suunnan hyväksi: nuori hahmo, top-down pixel art, rajattu paletti.

## Important conflicts resolved

1. **Perspektiivi:** aiempi sivusta/frontaali konseptikuva → **top-down / 3/4 yläviisto** kaikille asseteille.
2. **Tyyli:** aiempi maalauksellinen final art → **pixel art**, rajattu paletti, ei antialiasointia.
3. **Hahmon ikä:** aiempi aikuinen / nuorelta näyttävä → **oikeasti nuori**, mittakaava + siluetti kertovat iän.
4. **AI-kuvien status:** AI = referenssi, **ei** automaattisesti Godot-valmis sprite; aina pixel-grid-jälkikäsittely.
5. **Värilukko:** `#f2c166` vain valolle/toivolle; `#9aa64a` vain infectorille.
6. **Toteutus vs. dokumentaatio:** tämä on tuotanto-spec, ei integraatio; ei koodia, ei scene-muutoksia, ei asseteja peliin.

## Open questions

- lopullinen ikonikoko: 16×16 vs. 32×32 (riippuu HUD-mitoituksesta ja mobiililuettavuudesta)
- lopullinen sprite-koko: 32×48 vs. 32×32 hahmoille (validoidaan erässä 1)
- 4-suuntainen vs. pelkkä down v0.1:ssä
- AI-referenssi vs. täysin käsintehty tuotantomalli (GDD §23)
- pixel-grid-tiukkuuden taso (GDD §23)
- kuinka tumma paletti kestää halvalla mobiilinäytöllä (GDD §23)

## Next recommended safe task

**Tuota ensimmäinen tuotantoerä referensseinä `game/assets/references/`-tasolle** (§17, alkaen player idle down), aja jokainen §14:n jälkikäsittelyn ja §16:n checklistin läpi, ja **validoi erä 1 ennen muun tuottamista**. Ei peliin vientiä, ei Godot-integraatiota, ei koodia tässä vaiheessa.
