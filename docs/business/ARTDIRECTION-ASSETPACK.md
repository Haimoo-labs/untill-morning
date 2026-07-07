# Art Direction + Asset Pack Specification — Until Morning

**Rooli:** Hermes, Fridan (art director) hengessä — Frida ei ole vielä oma rakennettu skilli tässä tiimissä, joten tämä osuus on tehty yleisroolilla samalla senioriteetilla.
**Päivä:** 2026-07-07 (v2 — päivitetty: 2D yläviisto/top-down pixel art, nuoret hahmot, koko pelin assetpaketti)
**Tila:** Vain spesifikaatiota. Ei koodiin tai peliin vielä vietävää sisältöä — tietoinen Portti 3 -poikkeus, jonka omistaja on hyväksynyt rinnakkaiseksi suunnittelutyöksi.
**Syöte:** `docs/business/CHARACTER-ROSTER.md` (Ludo, v2 — nuoret hahmot, top-down), `docs/game-design-blueprint.md`, `game/assets/placeholders/icon.svg`, `game/project.godot`.
**Tarkoitus:** Kopioitavaksi suoraan ChatGPT:hen kuvien/assettien generointia varten.

**Muutos v1:sta:** Omistaja korjasi kaksi suuntaa: (1) peli on **2D yläviistosta (top-down) kuvattu**, ei sivusta/frontaalisti; (2) hahmot ovat **nuoria**, ei väsyneitä keski-ikäisiä. Tämä versio korvaa v1:n kokonaan ja laajentaa assetpaketin kattamaan koko pelin (ympäristö, rakenteet, esineikonit, efektit), ei vain hahmot/olennot.

---

## 1. Visuaalinen tyyliopas

### Mieliala

Synkkä, niukka, kylmä. Ei apokalypsin spektaakkelia (ei palavia kaupunkeja, ei dramaattista tuhoa) — hiljaista hylättyyttä, joka on pahaenteisempää kuin räjähdykset. Kaikki näyttää kuluneelta ja korjatulta, ei kiillotetulta. Ei splatter-kauhua, ei sankarifantasiaa. Nuoruus ei tarkoita toivorikasta tai värikästä — nuori selviytyjä on silti peloissaan ja niukoissa oloissa, ei seikkailija.

### Näkökulma: 2D yläviisto (top-down)

Peli kuvataan ylhäältä viistosti, samaan tapaan kuin klassiset top-down-toimintaroolipelit (esim. Zelda-tyylinen 3/4-yläviisto, ei suoraan pystysuora kartta ylhäältä). Kaikki hahmot, olennot, rakenteet ja tiilet suunnitellaan **tästä kulmasta**, ei sivusta eikä frontaalisena muotokuvana. Käytännössä:

- Hahmot/olennot näkyvät pääasiassa päälaelta ja hartioiden/selän kautta (alaspäin katsova "front-facing top-down" -asento on yleisin oletussuunta), ei kasvokuvana.
- Tunnistettavuus tulee ääriviivasta, väristä ja varusteista ylhäältä katsottuna (hiukset, vaatteiden väri, kantama esine), ei kasvonilmeistä.
- Rakenteet (portti, telttamajoitus) suunnitellaan niin että niiden yläviisto-siluetti kertoo tilan (ehjä/vaurioitunut) ilman että pitää nähdä sivuprofiilia.

### Väripaletti

Projektin oma placeholder-ikoni (`game/assets/placeholders/icon.svg`) antaa jo oikean suunnan — jatketaan sitä johdonmukaisesti. Pixel art hyötyy tiukasta, rajatusta paletista enemmän kuin maalauksellinen tyyli, joten pidä tämä kurinalaisena:

| Rooli | Hex | Käyttö |
|---|---|---|
| Perusvarjo/tausta | `#151515` | Yö, varjot, ääriviivat |
| Lämmin aksentti (toivo/valo) | `#f2c166` | Nuotio, taskulamppu, aamunkoitto — ainoa lämmin väri koko paletissa |
| Tumma oliivi/maasto | `#30382f` | Metsä, maasto, kulunut kangas |
| Kylmä harmaa (päivä) | `#8a8f87` | Päivävalo, iho, kuolleet sävyt |
| Sairaalloinen keltavihreä | `#9aa64a` | Vain tartuttajazombi — erottaa sen hitaasta zombista silmäyksellä |
| Ruoste/veren tumma punaruskea | `#5c2e1f` | Vain vaurion/uhan korostuksiin — ei kirkasta verta |

Sääntö: **yksi lämmin väri koko paletissa** (`#f2c166`), kaikki muu kylmää/desaturoitua. Tämä pitää koko assetpaketin yhtenäisenä vaikka assetit generoitaisiin monessa erässä, monta kuukautta erillään.

### Hahmosuunnittelun periaate: siluetti ja väriblokit ennen yksityiskohtaa

Top-down pixel artissa yksityiskohta ei kanna — tunnistettavuus tulee siluetista ja selkeistä väriblokeista (hiukset, vaatteen väri, kantama esine). Nuori päähahmo: ketterä, kevyt ryhti, ei koskaan leveä sankariasento — mutta myös ei kumaraa väsymystä; nuoruus lukeutuu nopeasta, kevyestä liikkeestä. Hidas zombi: raskas, nykivä, väistämätön kontuuri. Tartuttaja: sama perusrunko kuin hidas zombi mutta turvonnut/epämuodostunut siluetti, jotta ero lukeutuu heti ylhäältäpäin.

### Valo: kaksi tilaa, selkeä ero

- **Päivä/ilta:** kylmä, harmaa, väritön mutta turvallinen. Ei lämmin, ei uhkaava.
- **Yö:** pimeä, ahdistava, vain osittain valaistu niukalla lämpimällä valonlähteellä (nuotio/taskulamppu/kuu). Pimeys on osa uhkaa itseään.

### Tyylilaji: 2D top-down pixel art

**Pixel art, top-down/3-neljäsosa-yläviisto, matala resoluutio, rajattu paletti.** Ajattele klassisia indie-top-down-selviytymis-/roolipelejä. Terävät pikselit, ei antialiasointia, ei liukuvärejä (pieniä valohaalistuksia lukuun ottamatta). Ei fotorealismia, ei maalauksellista pehmeyttä.

**Käytännön varoitus ChatGPT-generoinnista:** ChatGPT:n kuvageneraattori tuottaa usein "pixel art -tyylisiä" kuvia jotka NÄYTTÄVÄT pikselöidyiltä mutta eivät ole oikeasti puhtaalla pikseliruudukolla (pehmeitä reunoja, epätasaisia "pikseleitä"). Tämä on ok konseptikuviksi ja referenssiksi, mutta jos tarvitset lopullisia peliin vietäviä spritejä, kuvat kannattaa jälkikäsitellä (pienennä + väripaletin rajaus/kvantisointi jollain pikselöinti-/indeksointityökalulla, esim. Aseprite tai vastaava) jotta ruudukko on aidosti puhdas. Mainitse tämä ChatGPT:lle promptissa ("clean pixel grid, no anti-aliasing") mutta odota silti tarvitsevasi jälkikäsittelyn.

---

## 2. Tekniset reunaehdot (Godot-integraatiota varten, myöhempi vaihe)

**Tärkeä huomio:** v0.1:n nykyinen UI (`main_controller.gd`) käyttää vain paljasta `Label`/`Button`-tekstiä — **yhtään kuva-assettia ei ole vielä kytketty peliin.** Tämä assetpack on ennakoivaa esituotantoa. Assettien vieminen oikeasti peliin (uudet `Sprite2D`/`TextureRect`/`TileMap`-noodit, scene-muutokset) on **oma, erillinen tehtävänsä** myöhemmin — kerro erikseen kun haluat sen tehtävän.

Kun assetit joskus viedään peliin:

- **Ruudukko/tile-koko:** suositus **32×32 px** perusruutu (yleinen top-down pixel art -standardi, toimii hyvin 720×1280-viewportissa: ~22 ruutua leveydeltä).
- **Hahmot/olennot:** suositus 32×32 tai 32×48 px lähtöruutu (jos tarvitaan hieman korkeampi hahmo kuin tile). Ylhäältäpäin kuvattu, keskitetty ruutuun.
- **Formaatti:** PNG, läpinäkyvä tausta kaikille sprite-/tile-assetteille.
- **Godot-tuontiasetukset (kun assetit tuodaan):** aseta filter-tila **Nearest** (ei Linear/mipmaps) jokaiselle pixel art -tekstuurille, jotta Godot ei sumenna pikseleitä skaalatessa. Tämä on tärkein yksittäinen asetus pixel art -tyylin säilyttämiseksi.
- **Lähtöresoluutio ChatGPT:stä:** generoi isompana (esim. 1024×1024) ja pienennä/kvantisoi tarkkaan tile-/spritekokoon jälkikäteen — älä luota ChatGPT:n tuottamaan alkuperäiseen pikselitarkkuuteen.

---

## 3. Yhtenäisyysstrategia ChatGPT-generointiin

1. **Liitä sama tyylietuliite jokaiseen promptiin** (alla) — ankkuroi väripaletin, näkökulman ja tyylilajin joka kerta.
2. **Kun ensimmäinen hyvä kuva on saatu (esim. päähahmo tai yksi tile), käytä sitä referenssinä jatkossa** (lataa se takaisin ChatGPT:hen: "sama tyyli/paletti, mutta ___") sen sijaan että generoit joka kerta pelkästä tekstistä. Tämä pitää koko paketin visuaalisesti yhtenäisenä paljon paremmin kuin toistuva tekstipohjainen generointi.
3. **Rakenna paketti järjestyksessä** (ks. kohta 5) niin että myöhemmät promptit voivat viitata jo hyväksyttyihin kuviin ("sama maasto-tyyli kuin edellinen ruohotiili, mutta poluksi").

### Jaettu tyylietuliite (liitä JOKAISEN promptin eteen)

```text
Style: 2D top-down pixel art for a grim mobile survival game, viewed from a 3/4 top-down angle (like a classic top-down survival/RPG game, not a side view or portrait). Clean, sharp pixel grid, no anti-aliasing, no soft gradients. Muted, cold, desaturated color palette (cool grays, dark olive, near-black shadows) with exactly one warm accent color (amber/gold, #f2c166) used only for light sources (firelight, dawn) — never on threats. No bright colors, no gore-red, no cheerful or cartoonish style. Characters and creatures must read clearly by silhouette and color blocking from above, not fine facial detail. Worn, patched, improvised aesthetic — nothing polished or heroic. Transparent background, centered composition, square canvas.
```

---

## 4. Assetlista ja promptit

Koko pelin graafinen assetpaketti: hahmot/olennot, ympäristö/tilet, rakenteet, esineikonit, efektit, UI. Järjestetty prioriteetin mukaan — **Prioriteetti 1 kannattaa generoida ensin**, koska se on ainoa joka koskee jo toteutettua v0.1-scopea.

### Prioriteetti 1 — v0.1-scope (toteutettu peli)

**4.1 Päähahmo — nuori selviytyjä ("Vahtija")**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a young survivor (late teens to early twenties), the last guardian of a makeshift gate. Not a soldier, not a chosen hero — an ordinary young person who happened to survive. Light, quick, alert posture — agile rather than tired, but still visibly scared and under-equipped, not confident or heroic. Worn, plain clothing (hoodie or light jacket, patched jeans or work pants, sturdy boots), a small self-repaired backpack. Carrying a weapon held cautiously, like something they're still learning to use, not mastering. Top-down 3/4 view, standing, facing toward viewer/downward. Cold daylight.
```

**4.2 Hidas zombi (slow zombie)**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a slow, relentless undead creature — heavy, jerky, inhumanly patient movement implied through posture, viewed from a top-down 3/4 angle. Still recognizably human — an ordinary former person, clothes partially intact — which makes it unsettling rather than monstrous. Cold, gray, bloodless coloring. Quiet dread, not splatter horror.
```

**4.3 Portti (the gate) — kaksi tilaa**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a top-down 3/4 view of an improvised barricade gate built from scavenged scrap — mismatched planks of different ages, rusted sheet metal, a car door, fence sections, hastily assembled by an ordinary person in desperation. NOT a fortress gate — rough, patched, visibly repaired multiple times.

Variant A (intact): sturdy but crude, patched but holding, blocking a path/gap.
Variant B (damaged): cracked, planks hanging loose, dark gaps showing through — looks like the next hit could be the last.

Dusk lighting, small warm firelight glow from one side.
```

**4.4 Ympäristö-tilet: base/tukikohta**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a single seamless-tileable top-down ground texture for a small, cramped, temporary-feeling survivor camp — packed dirt with worn patches, a few scattered boards. Square tile, designed to repeat edge-to-edge without visible seams. Cold gray daylight tone.
```

**4.5 Ympäristö-tilet: metsä (Forest-retki)**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a single seamless-tileable top-down ground texture for a bleak, overgrown forest floor — muted dark olive (#30382f) undergrowth, no vibrant greens, no storybook forest feel. Square tile, designed to repeat edge-to-edge without visible seams.
```

**4.6 Rakenne/objekti: leiripaikan tarvikkeet**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a small top-down cluster of survivor camp supplies — a modest pile of firewood, a small crate of scavenged food, a handful of kept ammunition rounds in an open tin. Scarcity should be visible — modest, not abundant. Individual small icon-like object, transparent background.
```

**4.7 Rakenne/objekti: nuotio**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a small top-down campfire — the single warm light source (#f2c166 glow) in an otherwise cold-toned camp. Transparent background, centered.
```

**4.8 Resurssi-ikonit (UI): food, wood, ammo**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: three small top-down/flat icon-style pixel art assets for a mobile game's resource HUD, same style and scale as each other: (1) a small ration/food icon (a can or wrapped ration, not fresh food), (2) a bundle of wood/planks icon, (3) a handful of ammunition rounds icon. Simple, flat, readable at very small size. Transparent background, each icon centered on its own square canvas.
```

**4.9 UI-ikoni: portin kunto**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a small icon representing gate/barricade health for a mobile game HUD — a simple plank-and-metal gate glyph, readable at small size, in two states: solid/intact and cracked/damaged. Transparent background, square canvas.
```

### Prioriteetti 2 — v0.2-scope (infektio, ei vielä toteutettu koodissa)

**4.10 Tartuttajazombi / infector**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a diseased, wrong-looking undead creature, top-down 3/4 view — same basic silhouette as the slow zombie but visibly swollen, cracked, or spreading with rot, signaling that mere contact is dangerous, not just its bite. Sickly yellow-green undertone (#9aa64a) against the otherwise cold palette — must be instantly distinguishable from the slow zombie at a glance from above.
```

**4.11 Resurssi-ikoni: lääke (medicine)**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a small top-down/flat icon-style pixel art asset for a mobile game HUD — a modest improvised medicine item (a worn pill bottle or a hand-wrapped bandage roll), matching the style and scale of the food/wood/ammo icons. Transparent background, centered on square canvas.
```

**4.12 Ympäristö-tile: apteekki-retki (pharmacy)**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a single seamless-tileable top-down ground/floor texture for a ransacked, abandoned pharmacy interior — cracked tile floor, scattered debris implied through subtle texture only (no large objects on the tile itself). Cold, desaturated tone. Square tile, repeats edge-to-edge without visible seams.
```

### Prioriteetti 3 — v0.3-scope (loot-valinta, ei vielä toteutettu koodissa)

**4.13 UI-ikoni: reppu (backpack, 6 paikkaa)**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a small flat icon-style pixel art backpack asset for a mobile game HUD, representing a 6-slot inventory, matching the style and scale of the other resource icons. Transparent background, centered on square canvas.
```

**4.14 Resurssi-ikoni: metalli (metal, rautakauppa-retki)**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a small top-down/flat icon-style pixel art asset for a mobile game HUD — a small scrap-metal piece/sheet icon, matching the style and scale of the other resource icons. Transparent background, centered on square canvas.
```

### Prioriteetti 4 — v0.5-scope NPC:t (ei vielä toteutettu koodissa)

**4.15 Trader / kauppias**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a young-to-adult survivor, top-down 3/4 view, who has made bartering their survival strategy — not a friend, a transaction. Carrying visible pouches/bags of traded goods, watchful posture, body language ready to leave quickly. Not menacing, but not warm either — cold and deliberate.
```

**4.16 Nurse / hoitaja**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a young-to-adult survivor, top-down 3/4 view, with remnants of medical/healthcare gear — a worn coat, a small improvised medical bag. Tired posture, not a saint or symbol of hope — a small, thin relief in the middle of the dark.
```

### Prioriteetti 5 — spekulatiivinen, EI HYVÄKSYTTYÄ SCOPEA (vain assetpackin ennakointia varten, älä toteuta koodiin)

**4.17 Ryntääjä (spekulatiivinen, v0.6+)**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a rare, fast, lean undead creature, top-down 3/4 view, with a tense, lunging silhouette — the opposite motion read from the slow zombie. Same cold color language.
```

**4.18 Murtaja (spekulatiivinen, v0.6+)**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a massive, armored-looking undead creature, top-down 3/4 view, bloated or debris-fused, reads instantly as "this one takes more than the others." Same cold color language.
```

### Prioriteetti 6 — efektit ja UI-kehykset (viimeistely, ei kriittistä)

**4.19 Efekti: aseen välähdys / osuma**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a small top-down muzzle-flash / impact-flash effect sprite, single frame, bright but brief-reading, using only the warm accent color (#f2c166) against transparency. Transparent background.
```

**4.20 UI-kehys: nappi ja paneeli**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a simple pixel art UI button frame and panel background for a mobile game menu, made of worn wood/metal matching the gate's material language — rough, patched, not shiny. Two states: normal and pressed. Transparent background where applicable.
```

---

## 5. Yhteenveto ja suositeltu järjestys

1. **Päähahmo (4.1)** ensin — tallenna referenssiksi.
2. **Hidas zombi (4.2)**, **portti (4.3)**, **base-tile (4.4)**, **metsä-tile (4.5)** — nämä + päähahmo kattavat kaiken mitä v0.1:n oma scope tarvitsee visuaalisesti.
3. **Leiritarvikkeet (4.6)**, **nuotio (4.7)**, **resurssi-ikonit (4.8)**, **portti-ikoni (4.9)** — nostavat v0.1:n HUD:in tekstistä ikoneiksi, halpa ja nopea parannus jos halutaan välipiste ennen isompaa visuaalista integraatiota.
4. Loput (4.10–4.20) tulevaa scopea (v0.2/v0.3/v0.5) tai spekulatiivista (v0.6+) — generoi ennakoiden, mutta ei niitä vastaa vielä mikään toteutettu peli.

**Muistutus:** kun kuvat on generoitu ja tarvittaessa jälkikäsitelty puhtaaksi pikseliruudukoksi, niiden **vieminen oikeasti Godot-peliin on oma erillinen tehtävänsä** (TileMap/Sprite2D-noodit, tuontiasetukset, scene-muutokset) — kerro kun haluat että se tehdään.
