# Tuotteistuksen roadmap — Until Morning

**Rooli:** Miranda (tuoteomistaja)
**Päivä:** 2026-07-07
**Pohja:** `docs/business/STRATEGY-ASSESSMENT.md` (Athena, GO EHDOLLISESTI)
**Tila:** Tuote- ja priorisointidokumentti. Kanoninen backlog on `docs/product/BACKLOG.md`. Tämä dokumentti tarkentaa portit ja kaupallisen suunnan, mutta ei tee monetisaatiopäätöksiä.

Vahvistettu lähtökohta: tämä on **kaupallinen tuloprojekti**, ei pelkkä portfolio. Se nostaa löydettävyyden (R1) ja monetisaatiomallin (R5) painoa, mutta ei muuta Portti 1:n päätöstä: prototyyppi viimeistellään joka tapauksessa.

Peliprojektin oma `CLAUDE.md` kieltää monetisaation ja mainokset ennen kuin ydinluuppi on pelattava. Tämä on kova sääntö, jota ei ohiteta. Kaikki raha on Portti 3:n takana ja vaatii erillisen omistajahyväksynnän.

---

## 1. Portti 1 — "v0.1 on pelattava" -valmiuskriteeristö

Tavoite: todistettavasti pelattava kolmen yön luuppi, ei "melkein valmis". Portti 1 on läpi vasta kun **kaikki** alla oleva on tosi ja todennettu oikealla Godot-ajolla, ei oletuksella.

### 1.1 Tehtävät tehty

Kaikki `docs/tasks/CLAUDE-CODE-TASKS-v0.1.md`:n tehtävät valmiit omilla hyväksymiskriteereillään:

- Task 001 — GameState laajennettu (kaikki v0.1-kentät, ei poissuljettuja järjestelmiä)
- Task 002 — Yhden scenen UI-vaiherender (kaikki vaiheet ja napit toimivat)
- Task 003 — Manuaalinen testikierros ajettu ja raportoitu
- Task 004 — Balanssikierros (Päivä 1 helppo, Päivä 2 riskialtis, Päivä 3 hävittävissä)
- Task 005 — v0.1 completion report kirjoitettu

### 1.2 Toiminnallinen luuppi (TEST-PLAN TC-001…TC-010)

`docs/prototype-v0.1/TEST-PLAN.md`:n kaikki 10 testitapausta tilassa **pass**. Portti 1:ssä "not tested" ei riitä itse luupin osalta, koska portin koko idea on että luuppi on ajettu:

1. Projekti aukeaa (TC-001)
2. Main scene ajautuu, päivä ja resurssit näkyvät (TC-002)
3. Metsäretki toimii ja antaa loottia (TC-003)
4. Ilta-näkymä tulee retken jälkeen (TC-004)
5. Portin korjaus toimii ja HP ei ylitä 100:aa (TC-005)
6. Yö ratkeaa, ammusten vaikutus ja portin vahinko näkyvät (TC-006)
7. Aamuraportti ilmestyy (TC-007)
8. Päivä etenee (TC-008)
9. Päivä 3:n jälkeen Prototype Complete (TC-009)
10. Portti 0 HP:ssä Game Over (TC-010)

### 1.3 Definition of Done R2

`docs/quality/DEFINITION-OF-DONE.md` R2:n Prototype v0.1 -tarkistukset kaikki tosi: Päivä 1 alkaa, metsäretki, ilta, portin korjaus, yö ratkeaa, aamuraportti, päivä etenee, prototyyppi valmistuu Päivä 3:n jälkeen, Game Over portin HP:n mennessä nollaan. Validointi tehty oikeasti tai puuttuva validointi merkitty eksplisiittisesti (luupin osalta ei sallita puuttuvaa).

### 1.4 Backlogin "Now" täyttyy

`docs/product/BACKLOG.md`:n "Now — Prototype v0.1" -listan kaikki kohteet olemassa (GameState, single-scene UI, Morning/Base, metsäretki, loot, ilta, portin korjaus, yön ratkaisu, aamuraportti, Game Over, Prototype Complete). "Do not build" -lista kunnioitettu: ei infektiota, säätä, NPC:itä, tallennusta, monetisaatiota.

### 1.5 Ydinpäätös on aidosti olemassa

`docs/mvp-scope.md`:n onnistumiskriteeri lunastettu: pelaaja kohtaa konkreettisesti valinnan **"käytänkö resurssit nyt vai riskeeraanko yön?"**. Ei tarkoita että peli on hauska (se on Portti 2), vaan että valintatilanne on koodissa ja pelattavissa.

### 1.6 Läpäisyn tiivistys

Portti 1 = läpi, kun: kaikki 5 taskia valmiit, TC-001…TC-010 pass oikealla ajolla, DoD R2 tosi, "Now"-lista katettu, scope siisti, ja ydinvalinta pelattavissa. Kirjattu Task 005:n completion reportiin. Vasta tämän jälkeen edetään Portti 2:een.

---

## 2. Portti 2 — sisäinen hauskuus-testi

Tämä on kallein virhelähde ja korkein arvo: hauskuus elää tai kuolee pelituntumassa. Athenan tavoitetunne on **"selvisin hädin tuskin, yksi päivä lisää"**. Tehdään siitä havainnoitava, ei mielipiteenvarainen. Otos on pieni (3–5 sisäistä testaajaa), joten tämä on **suuntasignaali, ei tilastollinen todiste**. Se riittää halpaan go/no-go-porttiin.

### 2.1 Asetelma

- 3–5 sisäistä testaajaa, jotka eivät ole nähneet designdokumentteja.
- Yksi "run" = yksi 3 yön läpipeluu (voitto tai häviö).
- Testaaja pelaa **ilman kehotusta jatkaa**. Ohjaaja ei sano "pelaa vielä yksi". Ohjaaja vain havainnoi ja ajastaa.
- Placeholder-taide ja äänettömyys kerrotaan etukäteen: "arvioi päätöstilannetta ja jännitettä, älä ulkoasua". Tämä suojaa väärältä hylkäävältä signaalilta (ks. R-P5).

### 2.2 Mitä mitataan (havaittavat signaalit)

1. **Oma-aloitteinen uudelleenpeluu.** Painaako testaaja Restartin ja aloittaa uuden runin ilman kehotusta Game Overin tai Prototype Completen jälkeen. Laske kpl per testaaja.
2. **Session syvyys.** Montako runia yhdellä istumalla vapaaehtoisesti. Mediaanitavoite ≥ 3 runia.
3. **"Yksi päivä lisää" -itsearvio.** Heti session jälkeen yksi kysymys: "Kuinka kova halu sinulla oli aloittaa heti uusi yritys?" asteikolla 1–5.
4. **Häviön omistajuus.** Kun testaaja häviää, selittääkö hän häviön **omalla valinnallaan** ("olisi pitänyt korjata portti", "tuhlasin ammukset") vai **sattumalla / epäreiluudella** ("peli huijasi", "randomi"). Tämä erottaa reilun jännitteen mielivaltaisesta satunnaisuudesta ja on hauskuuden ydinmittari.
5. **Päätöksen artikulointi.** Osaako testaaja kysyttäessä nimetä ydinvalinnan ("käytänkö nyt vai riskeeraanko yön"). Jos päätös ei tuntunut miltään, luuppi on lattea.

### 2.3 Läpäisykynnys

Portti 2 = läpi, kun **kaikki** seuraavat täyttyvät testaajajoukossa:

- Vähintään **3/5** (tai enemmistö) tekee vähintään yhden oma-aloitteisen uudelleenpeluun.
- Sessioiden **mediaani ≥ 3 runia** ilman kehotusta.
- "Yksi päivä lisää" -itsearvion **mediaani ≥ 4/5**.
- Enemmistö testaajista attribuoi häviönsä **omaan valintaansa**, ei sattumaan.
- Enemmistö osaa nimetä ydinvalinnan omin sanoin.

### 2.4 Jos ei läpäise

Ei rahaa eteenpäin. Vaihtoehdot: (a) **pivot luuppiin** — säädä balanssia (R-P4) tai päätösrakennetta ja testaa uudelleen, tai (b) **NO-GO**, jos toistettu säätö ei tuota "yksi päivä lisää" -tunnetta. Kumpikin on halvempi kuin rakentaa v0.6 todistamattoman hypoteesin varaan. Erityisesti: jos häviöt attribuoidaan sattumaan, ongelma on lähes aina balanssi tai läpinäkyvyys, ei sisällön puute — älä lisää ominaisuuksia, korjaa jännite ensin.

---

## 3. Kaupallinen roadmap-näkymä (v0.2–v0.6)

Kaupallisessa tuloprojektissa sessiopohjaisen design-vetoisen pelin ainoa kestävä valuutta on **retentio ja "yksi päivä lisää" -koukku**. Siksi priorisoin **päätössyvyyttä ja vaikeuskäyrää** ennen **vaihtelua ja kosmetiikkaa**. En poista mitään roadmapilta, vaan merkitsen kaupallisen painon ja järjestyksen.

| Versio | Sisältö | Kaupallinen paino | Suositus |
|--------|---------|-------------------|----------|
| v0.2 Infektio | 2. painetulo / päätösakseli | **Korkea** | Pidä. Ensimmäinen syvyyden kertoja luupin päälle. |
| v0.3 Loot-valinta (reppu) | Agenssi, "välitä mitä jätät" | **Korkea** | Pidä. Ydin push-your-luck-identiteetille ja replay-arvolle. |
| v0.4 Sää | Vaihtelu, "sama päivä tuntuu erilaiselta" | **Keskisuuri** | Slimmaa tai lykkää, jos kapasiteetti (R-P1) kiristää. Ei retention-ydin. |
| v0.5 NPC:t (kauppias, hoitaja) | Kevyt talous- ja päätösluuppi | **Keskisuuri–korkea** | Pidä kevyenä. Kauppias on paikka johon myöhempi ei-predatorinen meta/monetisaatio voi ripustua. Vartioi RPG-creepiä. |
| v0.6 7 yön MVP | Vaikeuskäyrä + "yksi päivä lisää usean session yli" | **Kriittinen** | Tämä on todellinen kaupallinen portti ja sisäinen build-kandidaatti. Roadmapin oikea maali. |

**Kaupallinen järjestyssuositus:** infektio (v0.2) ja loot-valinta (v0.3) ovat retention-koukun rakentajia ja tulevat ennen sää-vaihtelua (v0.4). Tämä on jo linjassa Athenan parking-lot-revisit-järjestyksen kanssa (infektio, sitten reppu/loot, sitten sää). Jos yhden hengen kapasiteetti pakottaa karsimaan, **sää on ensimmäinen slimmattava**, ei loot-valinta. 7 yön MVP (v0.6) on se kohta jossa retentio joko todistuu tai kaatuu, ja siihen kannattaa säilyttää polttoaine.

**Mitä ei kannata tehdä ennen v0.6:tta** (kanoninen lista säilyy BACKLOG.md:ssä): täysi kampanja, pakoauto, boss-yöt, IAP, mainokset, tilit, pilvitallennus, lopullinen taide/ääni. Näihin ei kosketa ennen kuin retentio on todistettu.

---

## 4. Suurimmat tuoteriskit prototyypin viimeistelyssä

| # | Riski | Vakavuus | Miksi tuoteriski | Lievennys |
|---|-------|----------|------------------|-----------|
| R-P1 | **Yhden hengen toteutuskapasiteetti.** ~32 riviä koodia vs. koko luuppi. Riski ikuisesta suunnitteluvaiheesta. | Korkea | Portti 1 ei valmistu ilman keskitettyä toteutusaikaa; kaikki muu odottaa tätä. | Task-per-task -kuri (001→005), aikaboksi (~40–80 h), ei uutta scopea ennen Portti 1:tä. |
| R-P2 | **Hauskuus todistamatta.** Koko arvo lepää ydinhypoteesin varassa. | Korkea | Jos Portti 2 kaatuu, v0.2–v0.6 on rakennettu tyhjän päälle. | Portti 2 määritelty ja halpa; aja heti kun luuppi pelattava. |
| R-P3 | **Verifiointi- ja Godot-osaamiskuilu.** DoD vaatii ajetun validoinnin; jos kukaan ei voi avata Godotia tai klikata TEST-PLANia läpi, "toimii" on katteeton. | Korkea | Portin 1 läpäisy on vain niin luotettava kuin sen validointi. | Varmista toimiva Godot 4.x -ympäristö ja ihminen joka ajaa TC-001…TC-010 ennen kuin Portti 1 julistetaan läpi. |
| R-P4 | **Balanssi kantaa hauskuuden.** "Hädin tuskin, yksi päivä lisää" syntyy vain tarkasta tahdituksesta (Pv1 helppo, Pv2 riski, Pv3 hävittävissä valinnoilla). | Korkea | Jos satunnaisuus tuntuu mielivaltaiselta, Portti 2 kaatuu vaikka koodi toimii. | Task 004 balanssikierros + Portti 2:n "häviön omistajuus" -signaali paljastaa mielivaltaisuuden. |
| R-P5 | **Placeholder-taide/äänettömyys vääristää hauskuustestiä.** Testaaja voi alipisteyttää ruman/hiljaisen buildin. | Keskisuuri | Väärä hylkäävä signaali Portti 2:ssa johtaisi turhaan pivottiin tai NO-GO:hon. | Ohjeista testaajat arvioimaan päätösjännite, ei ulkoasu; kynnys on "yksi päivä lisää", ei viimeistely. |
| R-P6 | **Scope-ajautuminen.** Roadmap ulottuu v0.6:een ennen kuin v0.1 pelattava. | Matala | Governance (hard rules, parking lot, "älä lisää ennen kuin luuppi pelattava") hillitsee tätä hyvin. | Säilytä kuri; uudet ideat parking lotiin, ei toteutukseen. |

---

## 5. Mitä päätetään Portti 2:n jälkeen (ei nyt)

Nämä ovat kaupallisia avoimia kysymyksiä, jotka **ratkaistaan vasta kun hauskuus on todistettu** ja ihminen on avannut Portti 3:n. Tässä vain suuntaviivat, ei päätöksiä eikä monetisaation yksityiskohtia:

1. **Retentio- ja meta-rakenne.** Mikä saa palaamaan session yli usean päivän ajan (v0.6:n ydinkysymys). Päätetään ennen tuotteistusrahaa.
2. **Löydettävyys ja koukku (R1).** Kyllästyneessä genressä orgaaninen näkyvyys on lähes nolla. Store-asemointi (design-vetoinen sessioselviytyjä vs. 4X-grindi) ja koukku pitää suunnitella ennen UA-rahaa. Draper valmistelee asemoinnin ilman rahasitoumusta.
3. **Monetisaatiomalli (R5).** Sessiopohjainen single-player on mobiilissa vaikea monetisoida. Malli on aito avoin kysymys, ja se **pysyy erillisen omistajahyväksynnän takana** (BACKLOG.md "Never without explicit approval"). Tässä dokumentissa ei valita mallia eikä suunnitella mainoksia/IAP:tä.

Kanoninen "Never without explicit approval" -osio BACKLOG.md:ssä pysyy voimassa muuttumattomana.
