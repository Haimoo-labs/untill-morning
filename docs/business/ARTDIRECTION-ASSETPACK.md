# Art Direction + Asset Pack Specification — Until Morning

**Rooli:** Hermes, Fridan (art director) hengessä — Frida ei ole vielä oma rakennettu skilli tässä tiimissä, joten tämä osuus on tehty yleisroolilla samalla senioriteetilla.
**Päivä:** 2026-07-07
**Tila:** Vain spesifikaatiota. Ei koodiin tai peliin vielä vietävää sisältöä — tietoinen Portti 3 -poikkeus, jonka omistaja on hyväksynyt rinnakkaiseksi suunnittelutyöksi.
**Syöte:** `docs/business/CHARACTER-ROSTER.md` (Ludo), `docs/game-design-blueprint.md`, `game/assets/placeholders/icon.svg`, `game/project.godot`.
**Tarkoitus:** Kopioitavaksi suoraan ChatGPT:hen kuvien/assettien generointia varten.

---

## 1. Visuaalinen tyyliopas

### Mieliala

Synkkä, niukka, kylmä. Ei apokalypsin spektaakkelia (ei palavia kaupunkeja, ei dramaattista tuhoa) — hiljaista hylättyyttä, joka on pahaenteisempää kuin räjähdykset. Kaikki näyttää kuluneelta ja korjatulta, ei kiillotetulta. Ei splatter-kauhua, ei sankarifantasiaa. Tavoite: pelaaja katsoo kuvaa ja tuntee "tämä ei kestä montaa yötä enää."

### Väripaletti

Projektin oma placeholder-ikoni (`game/assets/placeholders/icon.svg`) antaa jo oikean suunnan — jatketaan sitä johdonmukaisesti:

| Rooli | Hex | Käyttö |
|---|---|---|
| Perusvarjo/tausta | `#151515` | Yö, varjot, ääriviivat |
| Lämmin aksentti (toivo/valo) | `#f2c166` | Nuotio, taskulamppu, aamunkoitto, ainoa lämmin väri koko paletissa |
| Tumma oliivi/maasto | `#30382f` | Metsä, maasto, kulunut kangas |
| **Lisää (uudet, samaa henkeä):** | | |
| Kylmä harmaa (päivä) | `#8a8f87` | Päivävalo, iho, kuolleet sävyt |
| Sairaalloinen keltavihreä | `#9aa64a` | Vain tartuttajazombi — erottaa sen hitaasta zombista silmäyksellä |
| Ruoste/veren tumma punaruskea | `#5c2e1f` | Hyvin harkitusti, vain vaurion/uhan korostuksiin — ei kirkasta verta |

Sääntö: **yksi lämmin väri koko paletissa** (`#f2c166`), kaikki muu kylmää/desaturoitua. Lämmin väri on aina toivon/valon merkki (nuotio, aamu) — ei koskaan käytetä uhkaan. Tämä yksinkertainen sääntö pitää paletin yhtenäisenä vaikka assetit generoitaisiin monessa erässä.

### Hahmosuunnittelun periaate: siluetti ennen yksityiskohtaa

Jokaisen hahmon/olennon pitää olla tunnistettavissa pelkästä siluetista ja ryhdistä, ei kasvon ilmeestä (mobiilinäytöllä yksityiskohta ei kanna). Vahtija: kumarat hartiat, valpas mutta väsynyt ryhti — ei koskaan leveä sankariasento. Hidas zombi: raskas, nykivä, väistämätön kontuuri. Tartuttaja: sama perusrunko kuin hidas zombi mutta turvonnut/epämuodostunut siluetti, jotta ero lukeutuu heti pelissä.

### Valo: kaksi tilaa, selkeä ero

- **Päivä/ilta:** kylmä, harmaa, väritön mutta turvallinen. Ei lämmin, ei uhkaava.
- **Yö:** pimeä, ahdistava, vain osittain valaistu niukalla lämpimällä valonlähteellä (nuotio/taskulamppu/kuu). Pimeys on osa uhkaa itseään.

### Tyylilaji (kuvageneraatiota varten)

**Suositus: litteä, maalauksellinen, siluettivetoinen 2D-kuvitus — ei pikselitaide, ei fotorealismi, ei "söpö"/chibi-tyyli.** Perustelu: ChatGPT:n kuvageneraatio ei toista pikselitaiteen tarkkaa ruudukkoa luotettavasti eri promptien välillä, mikä rikkoisi visuaalisen yhtenäisyyden heti. Maalauksellinen, muotovetoinen tyyli (ajattele synkkää lastenkirjakuvitusta aikuisille, tai varjoteatterin ja realismin välimuotoa) on paljon toistettavampi ja sopii sävyyn paremmin kuin räikeä peli-pikseligrafiikka.

---

## 2. Tekniset reunaehdot (Godot-integraatiota varten, myöhempi vaihe)

**Tärkeä huomio:** v0.1:n nykyinen UI (`main_controller.gd`) käyttää vain paljasta `Label`/`Button`-tekstiä — **yhtään kuva-assettia ei ole vielä kytketty peliin.** Tämä assetpack on ennakoivaa esituotantoa, ei jotain mikä ilmestyy peliin automaattisesti. Assettien vieminen oikeasti peliin (uudet `Sprite2D`/`TextureRect`-noodit, scene-muutokset) on **oma, erillinen tehtävänsä** myöhemmin — ei tehdä nyt eikä ilman erillistä toteutuspyyntöä, koska se olisi Task 002:n scopen ylitys taannehtivasti.

Kun assetit joskus viedään peliin:

- **Viewport:** 720×1280 (pystysuunta, `game/project.godot`). Suunnittele kuvat niin että ne toimivat kapeassa pystyformaatissa (esim. hahmokuvat pystykehyksessä, ei leveinä panoraamoina).
- **Formaatti:** PNG, läpinäkyvä tausta hahmoille/olennoille (ei taustaväriä irrallisiin spriteihin).
- **Resoluutio (karkea suositus):** hahmot/olennot ~1024×1024–1536×1536 lähtökuvaksi (skaalataan alas Godotissa tarpeen mukaan); ympäristötaustat 720×1280 tai suurempi samassa kuvasuhteessa.
- **Godot ei vaadi 2-potenssikokoja** (ei teknistä pakkoa), mutta pidä tiedostokoot kohtuullisina mobiilille.

---

## 3. Yhtenäisyysstrategia ChatGPT-generointiin

ChatGPT:n kuvageneraatio ei takaa täysin identtistä hahmoa kahdesta erillisestä tekstipromptista. Kaksi käytännön ohjetta:

1. **Liitä sama tyylietuliite jokaiseen promptiin** (alla, "Jaettu tyylietuliite") — tämä ankkuroi väripaletin, valon ja tyylilajin joka kerta.
2. **Kun ensimmäinen hahmokuva on hyvä, käytä sitä referenssinä jatkossa** (lataa se takaisin ChatGPT:hen ja pyydä "sama hahmo, mutta ___") sen sijaan että generoit uudelleen pelkästä tekstistä joka kerta. Tämä pitää päähahmon yhtenäisenä eri poseissa/tilanteissa paljon paremmin kuin toistuva tekstipohjainen generointi.

### Jaettu tyylietuliite (liitä JOKAISEN promptin eteen)

```text
Style: flat, painterly 2D illustration for a grim mobile survival game. Muted, cold, desaturated color palette (cool grays, dark olive, near-black shadows) with exactly one warm accent color (amber/gold, #f2c166) used only for light sources (firelight, dawn) — never on threats. No bright colors, no gore-red, no cheerful or cartoonish style, no photorealism, no pixel art. Characters and creatures must read clearly by silhouette and posture, not fine detail. Worn, patched, improvised aesthetic — nothing polished or heroic. Portrait aspect ratio.
```

---

## 4. Assetlista ja promptit

Järjestetty prioriteetin mukaan — **ylimmät kolme kannattaa generoida ensin**, koska ne ovat ainoat jotka koskevat jo toteutettua v0.1-scopea. Loput ovat tulevaa scopea (v0.2/v0.5) tai spekulatiivisia (v0.6+, merkitty selvästi).

### Prioriteetti 1 — v0.1-scope (toteutettu peli)

**4.1 Päähahmo — "Vahtija"**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a tired, ordinary survivor in their 40s-50s, the last guardian of a makeshift gate. Not a soldier, not a hero — a weary person who happened to survive. Slightly hunched shoulders, alert but exhausted posture, ready to flee as much as to fight. Wearing worn work clothes or a patched coverall, scuffed boots, a self-repaired improvised backpack — clothing that hints at an ordinary pre-crisis life (janitor, groundskeeper, warehouse worker), not tactical gear. Carrying a rifle held reluctantly, like a tool, not a weapon they've mastered. Full body, standing, portrait orientation, cold daylight.
```

**4.2 Hidas zombi (slow zombie)**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a slow, relentless undead creature — heavy, jerky, inhumanly patient movement implied through posture. Still recognizably human — an ordinary former neighbor or passerby, clothes partially intact — which makes it unsettling rather than monstrous. Cold, gray, bloodless coloring. Quiet dread, not splatter horror. Full body, portrait orientation, dusk lighting.
```

**4.3 Portti (the gate) — kaksi tilaa**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: an improvised barricade gate built from scavenged scrap — mismatched planks of different ages, rusted sheet metal, a car door, fence sections, hastily nailed together by an ordinary person in desperation. NOT a fortress gate — rough, patched, visibly repaired multiple times.

Variant A (intact): sturdy but crude, patched but holding.
Variant B (damaged): cracked, planks hanging loose, dark gaps showing through — looks like the next hit could be the last.

Portrait orientation, dusk lighting, small warm firelight glow from one side.
```

### Prioriteetti 2 — base/ympäristö (v0.1-scope, tukikohta)

**4.4 Tukikohta, päivä**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a small, cramped, temporary-feeling survivor camp — one person's last remaining space. No comfort, no abundance. A little visible stored food, a small pile of wood, a few kept rounds of ammunition — scarcity should be visible, not hidden in a menu. Worn signs of long makeshift living: patched objects, no decoration. Cold gray daylight, calm but not warm. Portrait orientation.
```

**4.5 Tukikohta, yö**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: the same makeshift survivor camp at night — dark, tense, only partially lit by a single small warm firelight source (#f2c166 glow). The gate barely visible at the edge of the light, darkness pressing in beyond it. Portrait orientation, high tension mood.
```

### Prioriteetti 3 — v0.2-scope (infektio, ei vielä toteutettu koodissa)

**4.6 Tartuttajazombi / infector**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a diseased, wrong-looking undead creature — same basic silhouette as the slow zombie but visibly swollen, cracked, or spreading with rot, signaling that mere contact is dangerous, not just its bite. Sickly yellow-green undertone (#9aa64a) against the otherwise cold palette — must be instantly distinguishable from the slow zombie at a glance. Full body, portrait orientation, dusk lighting.
```

### Prioriteetti 4 — v0.5-scope NPC:t (ei vielä toteutettu koodissa)

**4.7 Trader / kauppias**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a calculating survivor who has made bartering their survival strategy — not a friend, a transaction. Carrying many pouches/bags of traded goods, watchful eyes, body language ready to leave quickly. Not menacing, but not warm either — cold and deliberate. Full body, portrait orientation, cold daylight.
```

**4.8 Nurse / hoitaja**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: an exhausted survivor with remnants of medical/healthcare gear — a worn coat, improvised medical supplies, tired eyes, hands that have done too much. Not a saint or symbol of hope — a small, thin relief in the middle of the dark. Full body, portrait orientation, cold daylight.
```

### Prioriteetti 5 — spekulatiivinen, EI HYVÄKSYTTYÄ SCOPEA (vain assetpackin ennakointia varten, älä toteuta koodiin)

**4.9 Ryntääjä (spekulatiivinen, v0.6+)**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a rare, fast, lean undead creature with a tense, lunging silhouette — the opposite motion read from the slow zombie. Same cold color language. Full body, portrait orientation.
```

**4.10 Murtaja (spekulatiivinen, v0.6+)**

```text
[liitä jaettu tyylietuliite tähän eteen]

Subject: a massive, armored-looking undead creature, bloated or debris-fused, reads instantly as "this one takes more than the others." Same cold color language. Full body, portrait orientation.
```

---

## 5. Yhteenveto ja suositeltu järjestys

1. Generoi ensin **päähahmo (4.1)** ja tallenna kuva talteen referenssiksi tuleviin variaatioihin.
2. Generoi **hidas zombi (4.2)** ja **portti, molemmat tilat (4.3)** — nämä kolme + päähahmo kattavat kaiken mitä v0.1:n oma scope tarvitsee.
3. Base-ympäristö (4.4–4.5) jos halutaan taustakuvia jo nyt.
4. Loput (4.6–4.10) ovat tulevaa/spekulatiivista scopea — generoi jos haluat ennakoida, mutta ne eivät vastaa mitään tällä hetkellä toteutettua peliä.

**Muistutus:** kun kuvat on generoitu, niiden **vieminen oikeasti Godot-peliin on oma erillinen tehtävänsä** (scene-/koodimuutokset main_controller.gd:hen ja main.tscn:ään) — kerro kun haluat että se tehdään.
