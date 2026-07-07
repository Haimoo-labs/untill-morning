# Game Design Document — Until Morning

> **SUPERSEDED (2026-07-07, ADR-005):** the canonical design source is now the design pack `docs/design-pack/` (owner adopted it over this GDD). Kept for history; do not base new work on this file. See `docs/decisions/ADR-005-design-pack-canonical.md`.

> Status: **v0.1 working design** · Owner roles: **Ludo (game design)** + **Frida (art direction / asset production lead)**
> Last updated: 2026-07-07
> This document is the single source of truth for design intent and scope. Code and asset integration are handled separately (see `docs/asset-production-specification.md`). If this document and the game disagree, **this document wins until it is deliberately changed.**

---

## 1. Executive Summary

**Until Morning** on synkkä, niukka ja kylmä selviytymispeli Androidille (mobile-first). Pelaaja ohjaa **oikeasti nuorta selviytyjää**, joka on liian nuori tilanteeseensa: hän puolustaa yhtä porttia yö kerrallaan maailmassa, joka on jo hävinnyt.

- **Mikä peli on:** 2D top-down / 3/4 yläviisto pixel art -selviytymispeli pystynäytölle (720×1280). Sykli on päivä → retki → ilta → yön puolustus → aamu.
- **Kenelle:** mobiilipelaajille, jotka pitävät kireästä resurssipeleistä ja "yksi yö lisää" -jännityksestä, eivät sankarifantasiasta tai räiskinnästä.
- **Ydintunne:** *Selvisin juuri ja juuri.* Pelaaja ei voita maailmaa — hän ostaa itselleen yhden aamun lisää.
- **Tärkein scope-rajaus juuri nyt:** rakennamme **v0.1 playable loopin**. Yksi hahmo, yksi vihollistyyppi (hidas zombi), yksi portti, yksi retkikohde (metsä), muutama resurssi, päivä/yö-rytmi. Ei infektiota, ei NPC:itä, ei craftingia, ei laajaa maailmaa v0.1:ssä.

Tämä dokumentti korjaa kaksi aiempaa virhettä, jotka on nyt lukittu:
1. **Hahmovirhe:** päähahmo on oikeasti nuori (myöhäisteini / hyvin nuori aikuinen), ei "nuorelta näyttävä aikuinen" eikä sankarisotilas.
2. **Asset-virhe:** kaikki assetit ovat **2D top-down / 3/4 yläviisto pixel art -peliassetteja** — ei sivuprofiileja, ei frontaalisia muotokuvia, ei maalauksellista konseptitaidetta lopullisena assettina.

---

## 2. High Concept

- **Yhden virkkeen kuvaus:** Liian nuori selviytyjä puolustaa yhtä porttia yö kerrallaan, ja jokainen aamu on voitto.
- **Pelaajan fantasia/tunne:** ei "olen sankari", vaan "pidin itseni hengissä vielä yhden yön, vaikka minulla ei ollut varaa siihen." Fantasia on sinnikkyys, ei voima.
- **Mikä tekee pelistä kiinnostavan:** niukkuus pakottaa oikeita päätöksiä. Jokainen resurssi on riittämätön. Portti murtuu, jos et valmistaudu, mutta valmistautuminen maksaa jotain muuta. Peli on painostava, luettava ja reilu.
- **Mikä peli EI ole:** ei laaja open world, ei RPG-dialogipeli, ei ensisijaisesti base-builder, ei sankariampumapeli, ei splatter-kauhu, ei söpö zombiepeli, ei cutscene-vetoinen tarinapeli. (Täysi lista: ks. §22 Non-Goals.)

---

## 3. Design Pillars

Jokainen pilari on sekä suunnittelun ohjenuora että portinvartija: jos ominaisuus ei tue pilaria, se ei kuulu peliin (ainakaan vielä).

### Pilari 1 — One more night
- **Mitä tarkoittaa:** koko peli on rakennettu tunteelle "selviydyin yhdestä yöstä lisää". Voitto ei ole maailman pelastaminen vaan aamun näkeminen.
- **Mekaniikassa:** selkeä yörytmi, näkyvä aamunkoitto palkintona, jokainen yö hieman vaativampi.
- **Visuaalisesti:** aamun lämmin `#f2c166` -valo on ainoa toivon signaali; yö on kylmä ja tumma.
- **Vältettävä:** loputon endless-grind ilman merkitystä; yön tekeminen pelkäksi aaltopuolustukseksi ilman emotionaalista latausta.

### Pilari 2 — Scarcity creates decisions
- **Mitä tarkoittaa:** peli on päätöksistä, ei refleksistä. Niukkuus tekee jokaisesta valinnasta merkityksellisen.
- **Mekaniikassa:** resursseja on aina liian vähän; jokainen käyttö on pois jostain muusta (korjaanko porttia vai säästänkö puun tuleen?).
- **Visuaalisesti:** tyhjä lattia, vähän objekteja, riisuttu HUD. Runsaus näyttäisi väärältä.
- **Vältettävä:** resurssien inflaatio, "kerää kaikkea" -täyttö, numeroiden kasvattaminen ilman valintaa.

### Pilari 3 — The gate is the heart
- **Mitä tarkoittaa:** portti on pelin sydän — mekaaninen tavoite ja emotionaalinen keskus. Kaikki mitä pelaaja tekee, tähtää portin pitämiseen.
- **Mekaniikassa:** portin kunto on tärkein häviön mittari; retket, resurssit ja yöpuolustus kietoutuvat portin ympärille.
- **Visuaalisesti:** portin kunto luetaan ilman numeroita — ehjä, vaurioitunut, lähes murtunut.
- **Vältettävä:** portin muuttaminen yhdeksi HUD-palkiksi muiden joukkoon; useiden yhtä tärkeiden tavoitteiden hajauttaminen.

### Pilari 4 — No hero fantasy
- **Mitä tarkoittaa:** päähahmo on nuori, kokematon ja haavoittuva. Rohkeus syntyy vaihtoehtojen puutteesta, ei sankaruudesta.
- **Mekaniikassa:** hahmo on hidas nostamaan asetta, pieni, helposti vaarassa; pako on yhtä pätevä valinta kuin taistelu.
- **Visuaalisesti:** liian iso takki, liian iso ase, pieni kapea siluetti, itse korjattu reppu. Ei sankariposeja.
- **Vältettävä:** power fantasy, "valittu sankari", aseasiantuntijuus, kylmäverinen tappokone.

### Pilari 5 — Readable from top-down view
- **Mitä tarkoittaa:** kaikki merkitys välittyy ylhäältä katsottuna — muodosta, väriblokista, liikkeestä ja siluetista, ei kasvonilmeestä tai cutscenestä.
- **Mekaniikassa:** uhka, resurssi, portin kunto ja hahmon tila on tunnistettava yhdellä silmäyksellä pelikentältä.
- **Visuaalisesti:** vahvat siluetit, erottuvat väriblokit, selkeät ikonit; ei detaljia, jota ei näy pienessä koossa.
- **Vältettävä:** informaatio, joka vaatii kasvojen näkemistä; frontaali-/sivuprofiilihahmot; liian pieni tai epäselvä sprite.

---

## 4. Target Platform and Controls

- **Alusta:** Android-first, mobiili. Työpöytä ei ole tavoite v0.1:ssä.
- **Orientaatio:** portrait, natiivi suunnitteluresoluutio **720×1280**.
- **Näkymä:** 2D top-down / 3/4 yläviisto.
- **Ohjaus:** kosketus. Perusliike joko virtuaalisella vasemmalla peukalo-ohjaimella (floating joystick) tai tap-to-move — tämä on avoin kysymys (ks. §23), mutta HUD on suunniteltava molempia tukevaksi.
- **Mobiili-HUD:** minimaalinen, näytön reunoille sidottu, ei peitä pelikenttää eikä hahmoa. Peukalovyöhykkeet huomioitava (alareunan nurkat).

**Mitä käyttöliittymän pitää mahdollistaa:**
- resurssien lukeminen yhdellä silmäyksellä
- portin kunnon lukeminen ilman numeroita
- päivä/yö-tilan hahmottaminen
- 1–3 kontekstuaalista toimintopainiketta (esim. korjaa portti, sytytä tuli, lähde retkelle)

**Mitä mobiililla pitää välttää:**
- pientä tekstiä ja pieniä osumakohteita (min. 44×44 dp)
- pelikentän peittämistä UI:lla
- monimutkaisia valikkopuita
- kahden käden tarkkuutta vaativaa ohjausta
- liian tummaa kontrastia, joka katoaa halvalla mobiilinäytöllä auringossa (ks. §23)

---

## 5. Core Loop

Ydinsykli on yksi vuorokausi. Se toistuu, kunnes pelaaja häviää.

1. **Päivä / valmistautuminen** — turvallinen mutta rajallinen aika. Pelaaja korjaa porttia, hoitaa leiriä, päättää retkestä. Aika on resurssi: kaikkeen ei ehdi.
2. **Retki / resurssien hankinta** — pelaaja lähtee metsään (v0.1) hakemaan puuta/ruokaa. Retki kuluttaa päivää; pimeä lähestyy.
3. **Ilta / valinta** — ratkaiseva päätöshetki: käytänkö viimeiset resurssit portin korjaukseen, tuleen, vai säästänkö huomiseen? Palaanko ajoissa vai otanko riskin vielä yhdestä resurssista?
4. **Yö / portin puolustus** — hidas zombimassa lähestyy porttia. Pelaaja puolustaa niukoilla keinoilla. Portin kunto ratkaisee.
5. **Aamu / selviytymisen seuraus** — jos portti kesti, koittaa aamu (lämmin `#f2c166` -valo). Pelaaja näkee, mitä yö maksoi, ja uusi päivä alkaa hieman kovemmilla ehdoilla.

- **Loopin tavoite:** selvitä yö ja päädy aamuun ilman, että portti murtuu tai hahmo kuolee.
- **Missä pelaaja tekee päätöksen:** ennen kaikkea illassa (vaihe 3) ja retken aikana (jäänkö vielä / palaanko).
- **Mikä tekee päätöksestä vaikean:** resursseja on aina liian vähän jokaiseen tarpeeseen yhtä aikaa. Portin korjaus, tuli ja ruoka kilpailevat samoista niukkuuksista.
- **Miten epäonnistuminen tuntuu reilulta:** uhka on hidas ja luettava; pelaaja näkee portin heikkenevän etukäteen. Häviö johtuu valinnoista, ei yllätyksestä tai reaktiotestistä.

---

## 6. v0.1 Scope

> **v0.1 on "feels like a game" -pystytys.** Tavoite: pelattava täysi vuorokausisykli, joka tuntuu oikealta peliltä, ei prototyypiltä. Kaikki alla oleva on tarkoituksella minimissään.

**v0.1 sisältää:**
- yksi pelattava hahmo (young survivor) top-down-liikkeellä
- yksi vihollistyyppi: hidas zombi (slow zombie)
- yksi portti, jolla on kunto (ehjä / vaurioitunut / lähes murtunut)
- yksi tukikohta/leiri (pieni ahdas pelialue portin takana), päivä- ja yöversio
- yksi retkikohde: metsä (puu/resurssi)
- resurssit: **food, wood, ammo, gate health**
- päivä/yö-rytmi ja aamu
- kosketusohjaus + minimaalinen mobiili-HUD
- häviötila (portti murtuu tai hahmo kuolee)

**v0.1 EI sisällä:**
- infektiota / infector-vihollista (v0.2)
- backpack/loot slot -päätöksiä (v0.3)
- NPC:itä, kauppaa, hoitajaa (v0.5)
- rautakauppaa, metallia, metalli-craftingia
- apteekkia / lääkettä
- sääjärjestelmää
- laajaa maailmaa tai useita karttoja
- tarinacutsceneja tai dialogipuita

**"Feels like a game" -minimitavoite v0.1:lle:**
pelaaja voi pelata täyden syklin (päivä → retki → ilta → yö → aamu), tehdä ainakin yhden merkityksellisen niukkuuspäätöksen, kokea portin heikkenemisen ja hävitä reilusti tai selvitä aamuun.

**Mitä pelaaja voi tehdä v0.1:ssä:**
- liikkua leirissä ja metsäretkellä
- kerätä puuta/ruokaa
- korjata porttia resursseilla
- puolustaa porttia yöllä hitaita zombeja vastaan
- selvitä aamuun tai hävitä

**Mitä pelaaja EI vielä voi tehdä v0.1:ssä:**
- craftata esineitä
- käydä kauppaa NPC:iden kanssa
- hoitaa infektiota
- hallita reppuslotteja
- matkustaa useisiin kohteisiin

**Mitä assetteja v0.1 oikeasti tarvitsee:** täydellinen lista `docs/asset-production-specification.md` §8. Tiivistys: young survivor idle + walk, slow zombie idle + walk, intact/damaged gate, base ground tile, forest ground tile, camp supplies, campfire, ikonit (food, wood, ammo, gate health intact/damaged).

---

## 7. Player Character

**Pelaajalle näkyvä hahmo:**
- oikeasti nuori selviytyjä — myöhäisteini tai hyvin nuori aikuinen
- **liian nuori tilanteeseen**; kokematon mutta pakon kautta karaistunut
- ei sotilas, ei valittu sankari, ei aseasiantuntija
- **liian iso takki / huppari** — vaatteet eivät ole hänen mittaansa
- **liian iso ase** — hän kantaa jotain, mihin ei ole tehty
- **pieni, itse korjattu reppu** — teipattu, väärän kokoinen, kotitekoinen
- pieni ja kapea top-down-siluetti; erottuu kokonsa puolesta vihollisista ja objekteista
- liike varovainen ja kevyt; valmis pakenemaan yhtä nopeasti kuin etenemään
- rohkeus syntyy vaihtoehtojen puutteesta, ei sankaruudesta

**Miten hahmo luetaan (top-down-lukko):** hahmo tunnistetaan **ylhäältä päin** varusteista, muodosta, väriblokeista ja liikkeestä — **ei kasvonilmeestä**. Nuoruus välittyy suhteista: pieni pää/hartialinja suhteessa isoon takkiin ja isoon aseeseen, kapea siluetti, epävarma keveä liike.

**Suunnittelijan taustaoletukset (EI kerrota cutscenellä, ei näytetä pelaajalle suoraan):**
- hahmolla on menneisyys ja menetyksiä, mutta niitä ei selitetä
- hahmo ei valinnut tätä roolia; hän on ainoa jäljellä
- ase ei ole hänen; se on löydetty tai peritty
- nämä ovat suunnittelun sävyä ohjaavia oletuksia, eivät pelin sisältöä

> **Turvallisuushuomio:** hahmon nuoruus välitetään mittakaavalla, siluetilla ja varusteilla top-down-näkymässä. Peli ei korosta eikä esitä lapseen kohdistuvaa väkivaltaa; uhka on abstrakti (hidas massa, portti). Ks. §23 avoin kysymys ikähaarukasta ja turvallisesta toteutuksesta.

---

## 8. Enemies

### v0.1 — Slow Zombie
- **Rooli:** "aika joka lähestyy porttia." Zombi on kello, ei säikäytys.
- hidas massa, ei nopeaa hyökkäystä
- uhka syntyy **määrästä ja väistämättömyydestä**, ei nopeudesta
- top-down-luettava: tunnistettava siluetista ja liikkeestä ylhäältä
- entinen tavallinen ihminen — kulunut, harmaa, ei hirviöfantasia, ei splatter
- värit kylmästä paletista (`#8a8f87`, `#30382f`); **ei** lämmintä `#f2c166`-väriä

### v0.2 — Infector *(tuleva scope — ei v0.1)*
- **toinen paineakseli:** uhkaa hahmoa infektiolla, ei vain enemmän vahinkoa
- ei "vahvempi zombi" vaan erilainen uhka, joka pakottaa uuden resurssin (medicine) hallintaan
- erottuu top-downissa **siluetilla** ja **sairaalloisella keltavihreällä `#9aa64a`** (tämä väri on varattu vain tartuttajalle)
- **Merkintä:** ei toteuteta v0.1-taskeissa.

### Future / Speculative *(spekulatiivinen — ei hyväksytty scope)*
- **runner (ryntääjä):** nopea uhka, joka rikkoisi hitaan rytmin — vaatii oman suunnittelunsa
- **breaker / murtaja:** portille erikoistunut uhka, joka kohdistaa vahingon porttiin
- **Merkintä:** nämä ovat ideoita, ei suunnitelmia. Ei saa käsitellä hyväksyttynä scopena.

---

## 9. The Gate

- **Rooli pelissä:** pelin sydän (Pilari 3). Portti on syy, miksi pelaaja tekee kaiken muun.
- **Mekaaninen rooli:** portilla on kunto (gate health). Se heikkenee yöllä ja korjautuu resursseilla (wood) päivällä. Kun kunto loppuu, peli on hävitty.
- **Emotionaalinen rooli:** portti on raja pelaajan ja loppumisen välillä. Sen katsominen pitää tuntea — se on hauras, väliaikainen, ainoa mikä erottaa hahmon yöstä.

**Portin kunto luetaan ILMAN numeroita, kolmessa tilassa:**
1. **Ehjä (intact):** suora, tiivis este-viiva; ei rakoja.
2. **Vaurioitunut (damaged):** näkyviä halkeamia, irtoavia osia, rakoja.
3. **Lähes murtunut (near-broken):** selvästi pettämässä, aukkoja, roikkuvia osia — hätätila.

**Top-down-esitys:** portti luetaan ylhäältä **este-viivana / nauhana** pelialueen reunalla, ei sivuprofiilina. Base on portin takana.

**Miten pelaajan pitää tuntea portin katsomisesta:** levottomuus ja vastuu. Ehjä portti = hetken helpotus; vaurioitunut = paine; lähes murtunut = paniikki ja pakko toimia. Tunne syntyy visuaalista, ei mittarista.

---

## 10. Base / Camp

- **Mitä se on:** yhden nuoren ihmisen viimeinen paikka. Pieni, ahdas, väliaikainen leiri portin takana.
- **Mitä se EI ole:** ei sotilastukikohta, ei kodikas base builder, ei kasvava tukikohtapeli.
- **Niukkuus näkyy:** paljas lattia, muutama objekti, improvisoidut tavarat. Tyhjyys on tarkoituksellista — se kertoo tilanteesta ilman tekstiä.

**Päiväversio:** kylmä harmaa päivävalo (`#8a8f87`), paljaat pinnat, näkyy kaikki mitä hahmolla ei ole.
**Yöversio:** tumma (`#151515`), ainoa lämpö on nuotio (`#f2c166`), joka valaisee pienen kehän. Yön base tuntuu turvattomalta.

**Pelialueena:** portin takana oleva pieni, ahdas kenttä, jossa pelaaja liikkuu, korjaa porttia ja puolustaa yöllä. Ahtaus on suunnittelun väline: se pakottaa läheisyyteen uhkan kanssa.

---

## 11. Locations

### v0.1 — Forest *(aktiivinen scope)*
- resurssi: **puu** (ja mahdollisesti ruoka) — selviytymisresurssi portin korjaukseen ja tuleen
- harmaa, kylmä metsä; **ei satumetsä**, ei vehreä, ei elävä
- nopea käynti ennen pimeää — retki on ajanhallintaa
- top-down tile-pohjainen alue

### v0.2 — Pharmacy *(tuleva scope — ei v0.1)*
- resurssi: **lääke (medicine)** infektion hallintaan
- kytkeytyy infector-viholliseen (§8 v0.2)
- **Merkintä:** vain tuleva scope.

### Future — Hardware Store *(tuleva / myöhempi scope)*
- resurssi: **metalli** korjaukseen ja craftingiin
- kytkeytyy backpack/loot- ja crafting-suunnitteluun
- **Merkintä:** vain tuleva scope; ei suunnitella v0.1:ssä.

---

## 12. Resources and Economy

Kaikki resurssit ovat tarkoituksella niukkoja (Pilari 2). Jokainen on aina "melkein riittävä".

| Resurssi | Mihin käytetään | Miten saadaan | Miksi ei liikaa | Liittyvä päätös |
|---|---|---|---|---|
| **Food** | pitää hahmo toimintakykyisenä päivien yli | metsäretki, myöhemmin loot | nälkä on jatkuva paine; ylimäärä poistaisi jännitteen | syönkö nyt vai säästänkö huomiseen |
| **Wood** | portin korjaus + nuotio | metsäretki | sama resurssi kahteen tarpeeseen → pakotettu valinta | korjaanko portin vai lämmitänkö/valaisenko |
| **Ammo** | yöpuolustus hitaita zombeja vastaan | aloitusvaranto + loot | vähäinen ammo pakottaa harkintaan ja pakoon | ammunko vai väistänkö/säästänkö |
| **Gate health** | häviön mittari; "elämä" jota puolustetaan | korjataan woodilla; heikkenee yöllä | jos ehtymätön, koko peli katoaa | kuinka paljon korjaan tänään |
| **Medicine** *(v0.2)* | infektion hoito | apteekki | pakottaa uuteen retkipäätökseen | hoidanko infektion vai otanko riskin |
| **Metal** *(v0.3+)* | vahvempi korjaus / crafting | rautakauppa | syvempi talous vasta myöhemmin | — (ei v0.1) |
| **Backpack slots** *(v0.3)* | rajaa mitä retkeltä voi tuoda | reppupäivitykset | rajallinen kantokyky pakottaa loot-valintaan | mitä jätän, mitä otan |

**Talouden periaate:** resurssit kilpailevat keskenään. Wood on tarkoituksella jaettu portin ja tulen välille, jotta jokainen ilta on aito valinta. Uusia resursseja lisätään vain, kun ne tuovat uuden päätöksen — ei koristeeksi.

---

## 13. Day/Night System

- **Päivä:** turvallinen mutta **rajallinen** päätösaika. Ei uhkaa, mutta aika loppuu: retki, korjaus ja valmistelu kilpailevat samasta päivästä. Kylmä harmaa valo.
- **Ilta (siirtymä):** viimeinen valintahetki ennen yötä; katso §5 vaihe 3.
- **Yö:** uhka-aika. Hidas zombimassa lähestyy porttia. Tumma, kylmä, ahdas.
- **Aamu:** palkinto ja hengähdys. Lämmin `#f2c166`-valo. Aamu on ainoa selkeä "voitto"-signaali pelissä.

**Miten rytmi tuottaa "yksi yö lisää" -tunteen:** sykli on lyhyt ja luettava, jokainen yö hieman kovempi, ja aamu antaa konkreettisen palkinnon (näet että selvisit). Pelaaja lopettaa aina ajatukseen "vielä yksi yö" — ei siksi, että peli pakottaa, vaan koska aamu tuntuu ansaitulta.

---

## 14. Failure and Survival

- **Miten pelaaja häviää:** (1) portin kunto loppuu yöllä, tai (2) hahmo kuolee. Molemmat ovat seurausta valinnoista, eivät sattumaa.
- **Miltä häviön pitää tuntua:** "olisin voinut tehdä toisin." Ei epäreilu, ei yllätys — pelaaja näki portin heikkenevän ja teki valinnat, jotka johtivat tähän.
- **Miten pelaaja oppii:** näkyvä syy-seuraus. Portti vaurioitui, koska et korjannut; loppui ammo, koska ammuit liian aikaisin. Palaute on visuaalista ja luettavaa.
- **Miksi peli ei saa tuntua epäreilulta:** uhka on hidas ja ennakoitava; ei reaktiotestejä, ei piilotettua tietoa, ei RNG-kuolemia. Vaikeus on suunnittelussa (niukkuus), ei julmuudessa.
- **Mitä "selvisin juuri ja juuri" tarkoittaa käytännössä:** aamu koittaa portin ollessa lähes murtunut, ammo lopussa, hahmo hädin tuskin pystyssä — ja se tuntuu voitolta. Peli on virittävä niin, että tämä on tavoiteltu, toistuva tunne.

---

## 15. Progression

- **v0.1 progression:** ei metaprogressiota. Progressio = selvitä pidemmälle. Vaikeus kasvaa yö yöltä. Ainoa "eteneminen" on pelaajan taito ja pidemmälle selviäminen.
- **Short-term progression:** portin korjaaminen vahvemmaksi, pieni resurssipuskuri, paremmat päätökset päivän sisällä.
- **Longer-term progression (myöhemmät versiot):** reppu (v0.3), kevyet NPC-venttiilit (v0.5), seitsemän yön MVP-tavoite (v0.6). Kaikki lisäävät päätöksiä, eivät tehoa.

**Mitä EI vielä tehdä:**
- ei liian nopeaa kasvua base builderiksi
- ei RPG-creepiä (tasoja, XP:tä, statteja)
- ei dialogipuita
- ei liian laajaa maailmaa liian aikaisin

---

## 16. NPC Design *(v0.5 scope — ei v0.1)*

NPC:t ovat **talousventtiileitä, eivät RPG-hahmoja.** Ne ovat "valikko jolla on kasvot" — tapa säädellä taloutta, ei tarinaa.

- **Trader:** vaihtaa resursseja toisiin (esim. food ↔ ammo). Säätää taloutta, antaa pelaajalle venttiilin niukkuuteen.
- **Nurse:** liittyy infektio/medicine-talouteen (v0.2+). Tapa hoitaa infektio resurssia vastaan.

**Ehdottomat rajat:**
- ei dialogipuita
- ei ystävyys-/mainemittareita
- ei cutsceneja
- ei nimettyä tarinaa tai juonta
- vuorovaikutus on käytännössä vaihtokauppavalikko, jolla on top-down-hahmo

**Merkintä:** NPC:itä ei toteuteta ennen v0.5:tä. Ei v0.1-taskeissa.

---

## 17. Art Direction Summary

*(Frida — art direction lock. Täydet tuotantosäännöt: `docs/asset-production-specification.md`.)*

- **Näkymä:** 2D top-down / 3/4 yläviisto — kaikki assetit tässä perspektiivissä.
- **Tyyli:** pixel art. **32×32 tile-ajattelu**; hahmo **32×48** tarvittaessa.
- **Rajoitettu paletti** (alla). Ei fotorealismia.
- **Ei** maalauksellista konseptitaidetta lopullisena assettina.
- **Ei** sivuprofiili- tai frontaalihahmoja.
- **Ei** sankariposeja. **Ei** söpöä chibi-tyyliä.
- Vahvat siluetit ja väriblokit; luettavuus pienessä koossa on ehdoton.

**Väripaletti:**

| Hex | Rooli |
|---|---|
| `#151515` | perusvarjo / yö / ääriviivat |
| `#f2c166` | **lämmin valo / toivo / nuotio / aamunkoitto** |
| `#30382f` | tumma oliivi / maasto / kulunut kangas |
| `#8a8f87` | kylmä harmaa / päivävalo / iho / kuolleet sävyt |
| `#9aa64a` | sairaalloinen keltavihreä / **vain tartuttajazombi** |
| `#5c2e1f` | ruoste / tumma vaurio / hyvin hillitty uhkakorostus |

> **Värisääntö (ehdoton):** lämmin `#f2c166` on **vain valolle ja toivolle** (nuotio, aamu, portin takainen turva). Sitä **ei koskaan käytetä uhkaan.** Uhka on kylmää, harmaata, ruosteista tai sairaan keltavihreää.

---

## 18. UI / HUD

Mobiili-HUD on **niukka** eikä peitä pelikenttää (Pilari 2 + Pilari 5).

- **Resurssinäyttö:** food, wood, ammo — pienet ikonit + luku, näytön yläreunassa.
- **Portin kunto:** näkyvä, numeroton indikaattori (ikoni ehjä/vaurioitunut); ensisijaisesti luetaan itse portista pelikentällä.
- **Päivä/yötila:** selkeä mutta hienovarainen tilan osoitin (esim. valon sävy + pieni ikoni/aikajana).
- **Toimintopainikkeet:** 1–3 kontekstuaalista, alareunan peukalovyöhykkeellä (korjaa portti, sytytä tuli, lähde/palaa).
- **Miten UI pysyy niukkana:** vain se, mitä päätöksen tekemiseen tarvitaan. Ei koristeltuja paneeleita, ei jatkuvia numeroita, ei ruudun peittäviä valikoita. UI katoaa taustalle, kunnes sitä tarvitaan.

---

## 19. Audio Direction

Ääni tukee niukkuutta ja painostusta — ei toimintaa.

- niukka ambient; pitkiä hiljaisuuksia
- kylmä tuuli perustunnelmana
- portin kolahdukset ja narahdukset (portin kunto kuuluu, ei vain näy)
- hidas, painostava zombimassa — matala, tasainen, kasvava läsnäolo
- **nuotion ääni ainoana lämpimänä äänielementtinä** (audio-vastine `#f2c166`-värille)
- **ei** toimintapeliorkesteria, ei sankarimusiikkia, ei jatkuvaa musiikkimattoa

---

## 20. Monetization / Commercial Direction

Realistinen ja kevyt. Peli ei saa tuntua halvalta.

- **Alusta:** Android-first.
- **Mallit (vaihtoehtoja):** premium (kertaosto) **tai** kevyt rewarded-ad -malli (vapaaehtoinen mainos pienestä hyödystä).
- **Mitä EI tehdä:** ei pay-to-win, ei pakotettuja mainoksia kesken jännityksen, ei energiamittareita, ei keinotekoista grindiä, ei aggressiivista IAP-suppiloa.
- **Retention** syntyy **"yksi yö lisää" -rakenteesta** (Pilari 1), ei keinotekoisesta grindistä tai päivittäisistä pakotteista.
- Ensimmäinen kaupallinen julkaisutavoite on avoin kysymys (§23).

---

## 21. Roadmap

Vaiheistus. **Vain v0.1 on aktiivinen scope.** Muut ovat suunniteltuja tulevia vaiheita — ei toteuteta etukäteen.

### v0.1 — Playable loop *(aktiivinen)*
- **Tavoite:** täysi vuorokausisykli, joka tuntuu peliltä.
- **Ominaisuudet:** young survivor, slow zombie, portti (3 tilaa), leiri (päivä/yö), metsäretki, resurssit (food/wood/ammo/gate health), päivä/yö-rytmi, kosketusohjaus, minimaalinen HUD, häviötila.
- **Asset-tarpeet:** ks. asset spec §8.
- **Riskit:** scope creep; top-down-luettavuus pienessä koossa; kosketusohjauksen tuntuma; liian tumma mobiilinäytöllä.
- **Definition of done:** pelaaja pelaa täyden syklin, tekee ainakin yhden niukkuuspäätöksen, kokee portin heikkenemisen, ja voi hävitä reilusti tai selvitä aamuun — mobiilipystynäytöllä kosketuksella.

### v0.2 — Infection
- **Tavoite:** toinen paineakseli talouteen.
- **Ominaisuudet:** infector-vihollinen, infektiomekaniikka, medicine-resurssi, apteekkikohde, infektio-UI-indikaattori.
- **Asset-tarpeet:** asset spec §9.
- **Riskit:** infektio voi tehdä pelistä epäreilun tuntuisen; toinen väriakseli (`#9aa64a`) ei saa sekoittua.
- **Definition of done:** infektio on hallittava mutta pelottava toinen paine, joka pakottaa uuteen retki-/resurssipäätökseen.

### v0.3 — Backpack / loot decisions
- **Tavoite:** loot muuttuu valinnaksi.
- **Ominaisuudet:** reppu ja rajalliset slotit, metal-resurssi, rautakauppa-kohde, loot-valinta-UI.
- **Asset-tarpeet:** asset spec §10.
- **Riskit:** inventaario voi liukua RPG-suuntaan; pidä valintana, ei varastonhallintana.
- **Definition of done:** pelaaja joutuu jättämään jotain arvokasta retkellä rajallisen kantokyvyn takia.

### v0.4 — Balance and tuning
- **Tavoite:** talous ja vaikeuskäyrä kohdalleen.
- **Ominaisuudet:** resurssien saannin/kulutuksen viritys, yökäyrän tasapaino, "juuri ja juuri" -tunteen kalibrointi.
- **Asset-tarpeet:** ei uusia asseteja; mahdollista polish-hienosäätöä.
- **Riskit:** viritys ilman dataa; liian helppo tai liian julma.
- **Definition of done:** tyypillinen pelisessio tuottaa toistuvasti "selvisin juuri ja juuri" -tunteen.

### v0.5 — Lightweight NPCs
- **Tavoite:** talousventtiilit kasvoilla.
- **Ominaisuudet:** trader, nurse, kevyt kauppa-UI (ei dialogipuita).
- **Asset-tarpeet:** asset spec §11.
- **Riskit:** NPC:t voivat houkutella RPG-suuntaan; pidä venttiileinä.
- **Definition of done:** NPC:t säätävät taloutta ilman RPG-rakenteita tai tarinaa.

### v0.6 — Seven-night MVP
- **Tavoite:** ehjä, julkaisukelpoinen kaari.
- **Ominaisuudet:** seitsemän yön rakenne alusta loppuun, vaikeuskaari, aloitus- ja lopputila.
- **Asset-tarpeet:** koonti + puuttuvat viimeistelyt.
- **Riskit:** kokonaisuuden eheys; tuntuuko seitsemän yötä oikealta MVP-kaarelta.
- **Definition of done:** pelaaja voi pelata täyden 7 yön kaaren, joka tuntuu kokonaiselta pelikokemukselta.

---

## 22. Non-Goals

Until Morning **EI ole:**
- ei laaja open world
- ei RPG-dialogipeli
- ei ensisijaisesti base-builder
- ei sankariampumapeli
- ei splatter-kauhupeli
- ei söpö zombiepeli
- ei tarinacutsceneihin nojaava peli
- ei liian monimutkainen mobiilille
- ei power/hero fantasy
- ei pay-to-win / grind-veto

Jos ehdotettu ominaisuus vie peliä johonkin näistä, se hylätään tai siirretään parking lotiin.

---

## 23. Open Questions / Conflicts

1. **Hahmon tarkka ikähaarukka:** lapsi, myöhäisteini vai hyvin nuori aikuinen? Suositus: **myöhäisteini** turvallisimpana, joka silti välittää "liian nuori" -tunteen. Vaatii lopullisen päätöksen.
2. **Turvallinen toteutus:** miten nuoruus näytetään ilman, että peli näyttää korostavan lapseen kohdistuvaa väkivaltaa? Suunta: abstrakti/hidas uhka, top-down-etäisyys, ei gorea, ei lähikuvia. Vaatii vahvistuksen.
3. **Kuinka tumma peli saa olla mobiilinäytöllä?** Synkkyys vs. luettavuus halvalla näytöllä kirkkaassa valossa. Vaatii testejä oikealla laitteella.
4. **Kuinka paljon oikeaa pixel-grid-puhtautta vaaditaan?** Tiukka grid vs. löyhempi tyyli. Vaikuttaa tuotantoputkeen.
5. **Tehdäänkö lopulliset assetit käsin/Asepritella vai käytetäänkö AI-kuvia vain referenssinä?** Nykysuositus (Frida): AI vain referenssinä, pixel-grid-jälkikäsittely aina. Vaatii päätöksen tuotantomallista.
6. **Ohjaustapa:** floating joystick vs. tap-to-move — kumpi tuntuu paremmalta top-down-selviytymisessä mobiililla? Vaatii prototyyppitestin.
7. **Ensimmäinen kaupallinen julkaisutavoite:** premium vai rewarded-ad, ja mikä versio (v0.6 MVP?) on ensimmäinen julkaisu?

---

## 24. Implementation Notes for Claude Code Agents

Nämä ohjeet koskevat jokaista agenttia, joka koskee tähän projektiin.

- **Tarkista scope ennen toteutusta.** Lue tämä dokumentti (§6 v0.1 Scope) ja backlog ennen kuin kirjoitat riviäkään. Jos tehtävä on v0.1:n ulkopuolella, pysähdy ja kysy.
- **Älä lisää uusia mekaniikkoja ilman backlog-muutosta.** Uusi mekaniikka vaatii dokumentti- ja backlog-päivityksen ensin.
- **Älä toteuta v0.2 / v0.3 / v0.5 -asioita v0.1-taskissa.** Infektio, reppu, NPC:t, crafting, apteekki, rautakauppa ja sääjärjestelmä ovat kiellettyjä v0.1-toteutuksessa.
- **Älä käsittele spekulatiivisia ideoita hyväksyttynä scopena.** Runner, breaker ym. ovat ideoita, eivät suunnitelmia.
- **Pidä dokumentti ajan tasalla.** Jos suunta muuttuu, päivitä tämä dokumentti samassa yhteydessä.
- **Pidä toteutus ja dokumentaatio erillään.** Tämä tehtävä (dokumentit) ei sisällä koodia, scene-muutoksia, asset-integraatiota, Sprite2D/TileMap/HUD-työtä eikä kuvien generointia.
- **Jokaisen uuden assetin pitää vastata top-down pixel art -lukkoa** (§17 + asset spec). Ei sivuprofiileja, ei frontaalimuotokuvia, ei maalauksellista final-artia, ei sankariposeja, ei aikuiselta näyttävää päähahmoa.
- **Godotissa pixel art -tekstuurit Nearest-filterillä**, ei antialiasointia lopullisissa peliaseteissa (yksityiskohdat asset spec §15).
- **AI-generoidut kuvat eivät ole automaattisesti lopullisia Godot-valmiita spritejä.** Ne pitää hyväksyä ja/tai jälkikäsitellä (pixel-grid, palette quantization, transparency, outline) ennen peliin vientiä.

---

## Source coverage

**Luetut tiedostot:** ei mitään — projektissa ei ollut yhtään tiedostoa dokumenttien luontihetkellä (2026-07-07). Tämä dokumentti perustuu kokonaan tehtävänannon eksplisiittisiin päätöksiin (Frida + Ludo -roolit, art direction, paletti, scope, hahmo- ja perspektiivilukot).

## Missing sources

Seuraavia lähdetiedostoja ei löytynyt (kaikki puuttuvat):
- `CLAUDE.md`
- `docs/game-design-blueprint.md`
- `docs/mvp-scope.md`
- `docs/product/BACKLOG.md`
- `docs/product/FEATURE-PARKING-LOT.md`
- `docs/business/FEELS-LIKE-A-GAME-MILESTONE.md`
- `docs/business/CHARACTER-ROSTER.md`
- `docs/business/ARTDIRECTION-ASSETPACK.md`
- `game/project.godot`
- nykyiset Godot-scriptit ja scene-tiedostot (ei olemassa)

> Kun nämä lähteet ilmestyvät, tämä dokumentti pitää sovittaa niiden kanssa ja mahdolliset ristiriidat ratkaista tämän dokumentin uuden suunnan hyväksi (nuori hahmo, top-down pixel art, tiukka v0.1-scope), ellei tiimi päätä toisin.

## Important conflicts resolved

1. **Hahmon ikä:** aiempi "aikuinen / nuorelta näyttävä aikuinen / sankarisotilas" → korjattu **oikeasti nuoreksi selviytyjäksi** (myöhäisteini / hyvin nuori aikuinen, liian nuori tilanteeseen).
2. **Asset-perspektiivi:** aiempi "sivusta/frontaali konseptikuva / maalauksellinen final art" → korjattu **2D top-down / 3/4 yläviisto pixel art -peliassetiksi**.
3. **AI-kuvien status:** AI-generoidut kuvat **eivät** ole automaattisesti lopullisia spritejä; ne ovat referenssejä ja vaativat pixel-grid-jälkikäsittelyn.
4. **Scope-selkeys:** v0.1, hyväksytyt tulevat vaiheet (v0.2–v0.6) ja spekulatiiviset ideat on eroteltu selvästi, jotta scope ei karkaa.
5. **Värisääntö:** lämmin `#f2c166` lukittu vain valolle/toivolle, ei koskaan uhkalle.

## Open questions

Ks. §23. Tärkeimmät: hahmon lopullinen ikähaarukka + turvallinen toteutus, mobiilin tummuus vs. luettavuus, pixel-grid-tiukkuus, AI vs. käsintehty tuotantomalli, ohjaustapa, ensimmäinen kaupallinen tavoite.

## Next recommended safe task

**Kirjoita/generoi v0.1-referenssit ja ensimmäinen tuotantoerä `docs/asset-production-specification.md`:n mukaan** (player idle down, slow zombie walk down, intact/damaged gate, base/forest ground tiles, food/wood/ammo-ikonit, campfire, gate health -ikoni) — **referensseinä ja spec-dokumenttina, ei peliin vietynä**. Ei koodia, ei scene-muutoksia, ei Godot-integraatiota. Vahvista §23:n avoimet kysymykset ennen lopullisten spritejen lukitsemista.
