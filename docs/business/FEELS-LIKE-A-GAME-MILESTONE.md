# Feels-Like-a-Game -virstanpylväs — Until Morning

**Rooli:** Ludo (pelisuunnittelija)
**Päivä:** 2026-07-07
**Tila:** Suunnitteluanalyysi. Ei muuta scopea, koodia eikä muita dokumentteja. Ristiviittaa: `docs/product/BACKLOG.md`, `docs/product/FEATURE-PARKING-LOT.md`, `docs/business/PRODUCTIZATION-ROADMAP.md`, `docs/business/BALANCE-TUNING-RECOMMENDATION.md`.

## Kysymys

Missä yksittäisessä vaiheessa (v0.1→v0.6) Until Morning ylittää rajan **"todistettu mekaniikka" → "tuntuu oikealta peliltä"** pelaajalle joka ei tiedä kehitysprosessista mitään.

Tämä ei ole sama kuin "onko hauska". Se on kysymys siitä, milloin peli lakkaa olemasta yksi kiinnostava päätös ja alkaa olla päätösavaruus: joukko toisiinsa vaikuttavia valintoja, jotka synnyttävät joka pelikerralla eri tarinan jonka pelaaja itse kirjoitti.

Arvioin jokaisen vaiheen neljällä konkreettisella kriteerillä: päätössyvyys, variaatio/toistoarvo, jännitteen kasvu, agenssi. En jää tasolle "onko kivaa".

---

## 1. Vaihe vaiheelta

### Vipujen määrä pelaajan kädessä (päätössyvyyden tiivistys)

| Vaihe | Aidot, itsenäiset vivut | Risteävätkö vivut |
|-------|-------------------------|-------------------|
| v0.1 Core Loop | **1** — korjaa portti vai älä | Ei. Yksi akseli (selviä yö). |
| v0.2 Infektio | **2** — portti + infektio; retkikohde (metsä vai apteekki) muuttuu aidoksi | Ensimmäistä kertaa kyllä: kohdevalinta vaihtaa tämän yön portin vahvuuden infektionhallintaan. |
| v0.3 Loot-valinta | **3–4** — kohde × repun sisältö × jako (korjaa/hoida/säästä) kahden akselin yli | Kyllä, joka silmukan vaiheessa. Trade-off trade-offin sisällä. |
| v0.4 Sää | 3–4 (sama) + kontekstikerroin | Ei uutta vipua. Tekee olemassa olevista tilannekohtaisia. |
| v0.5 NPC Light | 3–4 + talousventtiili (kauppias/hoitaja) | Lisää muunnosvivun, hienosäätää olemassa olevaa taloutta. |
| v0.6 7 yön MVP | Sama vipusto, 7 yön käyrä | Ei uutta vipua. Todistaa retention session yli. |

### v0.1 — Core Loop

- **Päätössyvyys: yksi vipu.** Ammukset kuluvat automaattisesti (ks. `BALANCE-TUNING-RECOMMENDATION.md` §1: ammus ei ole taitovipu, se on loot-RNG). Retki on pakotettu (vain metsä). Jäljelle jää yksi aito valinta: kuinka paljon puuta poltat porttiin illalla. Tasapaino on hiottu niin että tämä yksi valinta ratkaisee voiton ja häviön. Se on aito, mutta se on yksi.
- **Variaatio: matala.** Yksi lokaatio, satunnainen loot, sama optimaalinen ratkaisu joka kerta. Balanssidokumentti todistaa itse: `frugal` ja `panic` voittavat molemmat 100 %. Toinen läpipeluu on käytännössä sama kuin ensimmäinen, vain loot-RNG heittää.
- **Jännite: numeroiden kasvatusta.** 30/50/80. Ei uutta jännitetyyppiä, vaan sama seinä korkeampana. Se tuottaa aidon "selvisin 10 HP:llä" -hetken, mutta yhden 3 yön kaaren sisällä.
- **Agenssi: aito mutta kapea.** Tasapainotus teki häviöstä 100 % korjauspäätökseen jäljitettävän. Agenssi on siis olemassa eikä RNG kuljeta, mutta se on agenssia yhden päätöksen yli. Juuri tämä on Portti 2:n testauskohde.

**Verdikti: todistettu mekaniikka, ei vielä peli.** Toimiva atomi.

### v0.2 — Infektio

- **Päätössyvyys: toinen akseli, ja ensimmäinen vipujen risteys.** Portin rinnalle tulee infektio (lääke, apteekki, tartuttajazombi, hoitotoimi). Nyt retkikohde on aito valinta: apteekki (hallitse infektiota) vai metsä (hae puuta/ruokaa yötä varten). Apteekkiin meno tarkoittaa ettei saa puuta, mikä tarkoittaa heikompaa porttia tänä yönä. Tämä on ensimmäinen kerta kun kaksi vipua kytkeytyy toisiinsa.
- **Variaatio: kasvaa.** Run voi olla "infektiopainotteinen" tai "porttipainotteinen". Kaksi häviötapaa: portti murtuu tai infektio vie.
- **Jännite: kaksi eri muotoista painetta.** Akuutti yöllinen porttipiikki ja hidas infektioajastin rinnakkain. Eri jännitteen muoto, ei vain suurempi numero.
- **Agenssi: pelaaja valitsee minne mennä.** Aito haarautuma, ei enää pelkkä "kuinka paljon korjaan".

**Verdikti: lähellä, mutta ei vielä.** Kaksi hallittavaa ajastinta, mutta retkellä otat yhä sen mitä RNG antaa. Loop on rikkaampi, mutta run-to-run-tarina yhä melko yhtenevä. Pelaaja kuvaisi tätä "näppäränä selviytymispulmana jossa on kaksi asiaa balansoitavana", ei vielä "maailmana jossa teen valintoja".

### v0.3 — Loot-valinta (reppu)

- **Päätössyvyys: kolmas akseli, ja loot itsessään muuttuu päätökseksi.** 6-paikkainen reppu, manuaalinen loot-valinta, puu/metalli-tradeoff, rautakauppa. Nyt joka retkellä valitset: mitä kannan takaisin, mitä jätän. Yhdistettynä v0.2:n infektioon vivut kertautuvat: minne mennä (lokaatio) × mitä tuoda (reppu) × miten käyttää (korjaa vs hoida vs säästä) kahden kilpailevan akselin yli. Tässä trade-offit pesiytyvät sisäkkäin joka silmukan vaiheessa. Konkreettinen esimerkki: apteekissa, 6 paikkaa, täytänkö paikat lääkkeellä vai nappaanko ohittamani metallin. Valinta valinnan sisällä valinnan sisällä.
- **Variaatio: suurin hyppy.** Koska loot valitaan kapasiteettirajoitteen alla, jokainen run haarautuu sen mukaan mitä löysit ja mitä priorisoit. Ei yhtä optimaalista ratkaisua: se riippuu pelitilanteestasi. Kaksi läpipeluuta eroavat aidosti.
- **Jännite: mikrojännite joka retkelle.** Repun rajoite lisää "jäänkö vielä yhdelle tavaralle" -paineen makrojännitteen (yö) päälle.
- **Agenssi: huippuhyppy.** Pelaaja tekee nyt 3–4 aitoa päätöstä per päiväsilmukka yhden sijaan. Jokainen päätös on näkyvästi hänen omansa.

**Verdikti: tässä raja ylittyy.** Se lause jonka pelaaja kertoo pelistä muuttuu. v0.1: "korjasin ja selvisin". v0.3: "jätin metallin ja otin lääkkeen, ja se maksoi minulle portin neljäntenä yönä". Ensimmäinen on kuvaus mekaniikasta. Toinen on tarina jonka haarat pelaaja itse kirjoitti. Se on "oikean pelin" tuntumaa.

### v0.4 — Sää

- **Päätössyvyys: ei uutta vipua.** Sää (sade/sumu) on kontekstimuokkain: se muuttaa retki- ja yösääntöjä, tekee olemassa olevista päätöksistä tilannekohtaisia (sumussa retki on riskialttiimpi, ehkä älä mene). Kerroin variaatioon, ei uusi agenssin akseli.
- **Variaatio: kasvaa** ("sama päivä tuntuu erilaiselta"), mutta kerroksena jo valmiin päätösrakenteen päällä.
- **Jännite: lisää arvaamattomuutta**, mutta jännitteen perusmuoto on jo lyöty lukkoon v0.1–v0.3:ssa.
- **Agenssi: sää on pakotettu (RNG-konteksti), pelaaja reagoi.** Ei anna uutta vipua, vaan saa ympäristön vaihtelemaan.

**Verdikti: parannus, ei raja.** Jos poistaisit sään, v0.3 tuntuisi silti oikealta, toistettavalta peliltä. Sää on "enemmän peliä", ei "nyt tämä on peli".

### v0.5 — NPC Light

- **Päätössyvyys: talousventtiili.** Kauppias (vaihda ylijäämä X tarvittavaan Y:hyn) ja hoitaja (vaihtoehto lääkkeelle). Aitoja lisäpäätöksiä, mutta ne ovat venttiileitä olemassa olevaan resurssitalouteen, eivät uusi pilari.
- **Variaatio: kauppatarjoukset vaihtelevat runien välillä.**
- **Agenssi: enemmän vaihtoehtoja**, mutta v0.5:een mennessä peli tuntuu jo peliltä. Tämä syventää.

**Verdikti: syventää jo olemassa olevaa peliä.**

### v0.6 — 7 yön MVP

- Pituus, vaikeuskäyrä, luettavuus. Onnistumiskysymys on "haluaako pelaaja yhden päivän lisää usean session yli". Se on **retentio**, joka on korkeampi rima kuin "tuntuu peliltä". Peli voi tuntua täysin oikealta ja tyydyttävältä yhdessä sessiossa todistamatta vielä että se pitää pelaajan otteessaan session yli.

**Verdikti: rajan yli, mutta eri kysymys.** Kaupallinen ja retention-portti, ei "tuntuuko peliltä" -portti.

---

## 2. Nimetty vaihe: **v0.3 — Loot-valinta (reppu)**

Raja ylittyy v0.3:ssa. Perustelu miksi juuri se, ei aiempi eikä myöhempi:

**Miksei jo v0.2.** v0.2 on iso askel: se antaa toisen akselin ja tekee lokaatiovalinnasta ensi kertaa aidon. Mutta kaksi hallittavaa ajastinta, joissa loot on yhä automaattista, on yhä luettavissa "mekaniikaksi jossa on toinen ulottuvuus", ei "maailmaksi jossa teen valintoja". Se tuntu-ero jonka maallikkopelaaja rekisteröi "ai, tämä on oikea peli" on agenssi joka silmukan vaiheessa ja runien haarautuminen, ja juuri sen manuaalinen loot-valinta tuo. v0.2 on välttämätön pohja: se antaa loot-valinnalle jotain mitä vastaan punnita. Ilman infektiota reppuvalinta olisi vain "puuta vai puuta". v0.2 tekee valinnan mahdolliseksi, v0.3 tekee valinnan olemassa olevaksi. Raja ylittyy kun valinta on olemassa joka vaiheessa, eli v0.3:ssa.

**Miksei vasta v0.4–v0.6.** Sää (v0.4) ja NPC:t (v0.5) lisäävät peliin joka jo tuntuu peliltä. Ne ovat variaatiota ja talouden syvyyttä. Jos ne poistaisi, v0.3 tuntuisi yhä oikealta, toistettavalta peliltä. Ne ovat "enemmän peliä", eivät "nyt tämä on peli". v0.6 on retention-portti ("yksi päivä lisää session yli"), joka on vahvempi ja eri väite kuin "tuntuu peliltä kädessä". Peli voi tuntua täysin oikealta yhdessä sessiossa ja silti kaatua retention-testissä. v0.6 on siis kysytyn rajan tuolla puolen.

---

## 3. Ero Portti 2:een

Nämä kaksi kysymystä eivät ole sama, ja kumpikin on hyödyllinen eri syystä.

**Portti 2** (ks. `PRODUCTIZATION-ROADMAP.md` §2) testaa **onko v0.1:n YKSI päätös mielekäs ja reilusti jäljitettävä**. Mittarit: oma-aloitteinen uudelleenpeluu, session syvyys, "yksi päivä lisää" -itsearvio, häviön omistajuus, päätöksen artikulointi. Se testaa yhtä hypoteesia: "onko tämä yksi päätös pelaamisen arvoinen". Se **ei** testaa tuntuuko koko peli valmiilta. Portti 2 voi mennä läpi v0.1:llä (yksi korjauspäätös on aidosti jännittävä ja reilu) samalla kun peli **ei** vielä tunnu oikealta peliltä (koska se on yksi päätös, yksi lokaatio, yksi 3 yön kaari, eli todistettu lelu, ei vielä peli).

**Tämä kysymys** ("tuntuu oikealta peliltä") kysyy milloin päätösten ja systeemien **kertymä** ylittää rajan täydeltä peliltä tuntumiseen, ei mikroluupin todistamiseen.

Miksi kumpikin on hyödyllinen:

- **Portti 2 on portti perustukselle.** Jos atomipäätös ei ole hauska, mikään systeemien pinoaminen ei pelasta (Ludon oma periaate: kiillota luuppi ennen kuin rakennat mitään sen päälle). Se suojaa siltä että v0.2–v0.6 rakennetaan hiekalle. Se on halpa ja aikainen.
- **"Tuntuu peliltä" -virstanpylväs on merkki katolle.** Se kertoo aikaisimman pisteen jossa buildin voi laittaa ulkopuolisen pelaajan eteen ja hän kokee sen pelinä, ei teknodemona. Hyödyllinen kun suunnitellaan ensimmäisiä ulkoisia playtestejä, store-sivun kuvamateriaalia, traileria tai soft-launchin ajoitusta.

Eri epäonnistumistavat: Portti 2:n kaatuminen = ydin on rikki, pysähdy ja korjaa luuppi. "Tuntuu peliltä" -rajan saavuttamatta jääminen = ydin on kunnossa mutta risteävää päätösrakennetta ei ole vielä tarpeeksi, jatka rakentamista v0.3:een. Toinen on laatuportti atomille, toinen valmiusmerkki molekyylille.

---

## 4. Mitä v0.1:stä konkreettisesti puuttuu v0.3:n tasoon

v0.1:ssä on 1 vipu (korjaa). v0.3:ssa on karkeasti 3–4 risteävää vipua per silmukka. Erotus:

1. **Toinen resurssiakseli** (v0.2:sta): infektio, lääke, apteekki, tartuttajazombi, hoitotoimi. Jotta on enemmän kuin yksi haluamisen arvoinen asia.
2. **Toinen ja kolmas retkikohde** (apteekki, rautakauppa). Jotta MINNE-mennä on aito valinta, ei pakote.
3. **Manuaalinen loot-valinta kapasiteettirajoitteen alla** (6-paikkainen reppu, puu/metalli-tradeoff). Jotta MITÄ-tuoda on päätös ja runit haarautuvat.

Lyhyesti: **toinen lokaatio + manuaalinen loot-valinta + toinen resurssiakseli.** Huomaa että tämä vaatii sekä v0.2:n (toinen akseli) että v0.3:n (loot-valinta). Siksi nimetty raja on v0.3, se vaihe jossa viimeinen näistä paloista laskeutuu paikalleen. Se on hyppy "yhdestä päätöksestä" "päätösavaruuteen".

---

## 5. Ristiviittaus kaupallisiin prioriteetteihin

**BACKLOG.md-tagit:** v0.2 Korkea, v0.3 Korkea, v0.4 Keskisuuri, v0.5 Keskisuuri–korkea, v0.6 Kriittinen.
**FEATURE-PARKING-LOT.md revisit order:** 1. Infektio, 2. Reppu/loot, 3. Sää, 4. NPC:t, 5. 7 yön MVP.

**Linjassa, ei ristiriitaa järjestyksessä.** Molemmat asettavat v0.2 ennen v0.3 ennen v0.4. Suositukseni nojaa juuri tähän: manuaalinen loot-valinta (v0.3) on kiinnostava vain jos on kilpailevia asioita joista valita, ja infektio (v0.2) on se toinen akseli joka antaa repulle jotain mihin purra. Revisit order (infektio → reppu → sää) on siis oikea, ja suositukseni vahvistaa sen.

**Kaksi nyanssia nostettavaksi esiin, ei ristiriitaa vaan tarkennus:**

1. **Älä anna v0.6:n "Kriittinen"-tagin luoda harhaa siitä että peli "muuttuu oikeaksi" vasta v0.6:ssa.** Kaupalliset dokumentit kehystävät v0.6:n oikeaksi kaupalliseksi portiksi (Kriittinen) ja v0.2/v0.3:n "retention-koukun rakentajiksi". Tämä on oikein retention-mielessä. Mutta *tuntuu peliltä* -hetki on aiempi (v0.3). v0.6 on se kohta jossa jo-oikea peli todistaa pitävänsä pelaajan session yli. Jos tämä ero hämärtyy, riski on että v0.3:n kiillotus lykätään ("oikea portti on kuitenkin v0.6"), vaikka juuri v0.3 on aikaisin build joka kannattaa näyttää ulkopuoliselle pelaajana eikä demona.

2. **v0.4 sää on tagattu "ensimmäinen slimmattava" (R-P1).** Analyysini tukee tätä itsenäisesti: sää on variaatiota jo valmiin päätösrakenteen päällä, joten sen slimmaus ei poista "tuntuu peliltä" -ominaisuutta. Jos yhden hengen kapasiteetti kiristää, sään lykkääminen v0.3:n jälkeen on turvallista tälle virstanpylväälle, loot-valinnan lykkääminen ei.

---

## Suositus

**Raja "todistettu mekaniikka → tuntuu oikealta peliltä" ylittyy v0.3:ssa (Loot-valinta / reppu).** Vasta siinä loot muuttuu itsessään valinnaksi kapasiteettirajoitteen alla ja kertautuu v0.2:n toisen akselin kanssa, jolloin pelaaja tekee 3–4 risteävää päätöstä per silmukka ja jokainen run haarautuu omaksi tarinakseen. v0.1–v0.2 ovat välttämätön pohja (yksi todistettu päätös, sitten toinen akseli), v0.4–v0.6 ovat variaatiota, taloutta ja retentiota jo-oikean pelin päälle.
