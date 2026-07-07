# Character Roster — Until Morning

**Rooli:** Ludo (pelisuunnittelija)
**Päivä:** 2026-07-07
**Tila:** Suunnittelu- ja hahmospesifikaatio. EI koodia, EI kuvia, EI kuvagenerointi-promptteja, EI teknistä asset-formaattia. Ristiviittaa: `docs/game-design-blueprint.md`, `docs/mvp-scope.md`, `docs/product/BACKLOG.md`, `docs/product/FEATURE-PARKING-LOT.md`, `docs/business/FEELS-LIKE-A-GAME-MILESTONE.md`.

## Tarkoitus ja rajaus

Tämä dokumentti kuvaa Until Morningin hahmoroosterin **kuka–mitä–miksi–tuntuma** -tasolla. Se on syöte art directionille (Frida), joka muuttaa nämä kuvausvaraukset kuvageneraatio-aihioiksi. En kirjoita itse kuvausvaraushakuja enkä teknisiä asset-tietoja: se on toinen rooli.

Tietoinen poikkeus normaalista Portti-järjestyksestä: taide kuuluisi vasta Porttiin 3, mutta omistaja on hyväksynyt tämän suunnittelutyön rinnalle nyt. Tämä on **vain spesifikaatiota**, ei koodiin tai peliin vietävää sisältöä.

### Sävylukko (kaikkia hahmoja koskee)

Synkkä, niukka, selviytymisjännite. **Ei sankarifantasiaa.** Tavoiteltu tunne on "selvisin juuri ja juuri. Yksi päivä lisää." Jokaisen hahmon pitää näyttää kuluneelta, ei kiillotetulta: korjatut vaatteet, improvisoidut varusteet, kylmä valo, väsynyt liike. Kuluneisuus on olosuhteissa ja varustuksessa, EI iässä — hahmot ovat nuoria, mutta olot ovat vieneet heistä veron. Kukaan ei ole voittaja, kaikki ovat kestäneet toistaiseksi.

### Perspektiivilukko: peli kuvataan 2D yläviistosta (top-down)

**Koko roosteri suunnitellaan ylhäältä päin kuvattuna, ei frontaalisena muotokuvana.** Peli näyttää hahmot kolmiperspektiivistä ylhäältä (ks. CLAUDE.md: 2D/2.5D). Käytännössä tämä tarkoittaa että hahmo ja olento tunnistetaan **yleissiluetista, liikkeen tyylistä ja väri- tai varustustunnisteesta ylhäältä katsottuna** — ei kasvonilmeistä, katseesta tai ryhdistä sivusta. Kasvot ovat käytännössä lakin, hiusten tai hartioiden yläpuoli; ilme ei kanna informaatiota. Kaikki tämän dokumentin visuaaliset kuvaukset on luettava tästä näkökulmasta: mikä erottaa hahmon ylhäältä yhdellä silmäyksellä. Tunnistettavuuden kantavat hartialinja, pään ja hartioiden muoto, varusteiden ääriviiva (reppu, aseen piippu, kantamukset), askelluksen rytmi ja värikoodi — eivät kasvonpiirteet.

### v0.1 hard rule: hahmo välittyy ilman sanoja

CLAUDE.md kieltää tarinacutscenet ja v0.1:ssä ei ole dialogia. Siksi **päähahmo ei saa persoonaansa tekstistä vaan ainoastaan visuaalisesti ja pelimekaniikan kautta.** Design-ohje art directionille: kaikki mitä hahmosta pitää tietää, on luettava yhdestä ylhäältä kuvatusta hahmosiluetista ja siitä miltä tekeminen tuntuu. Ei nimikylttejä pelissä, ei taustatarinaa ruudulla. Nimet ja taustat tässä dokumentissa ovat suunnittelijan ja taiteilijan työkaluja, eivät pelaajalle näytettävää tekstiä.

---

## 1. Päähahmo — pelattava selviytyjä

### Arkkityyppi

**"Vahtija".** Ei sotilas, ei sankari, ei valittu. Nuori ihminen joka sattui jäämään henkiin ja jonka koko olemassaolo on kutistunut yhteen tehtävään: pitää tämä yksi portti pystyssä yksi yö kerrallaan. v0.1-tasolla nimi ei ole tarpeen — hahmo tunnetaan siitä mitä hän tekee, ei siitä kuka hän on.

### Ikä ja tausta-vihje

Nuori — myöhäisteini tai parikymppinen. Ei sillä että hän olisi tarmoa täynnä, vaan sillä että hän on liian nuori tähän: joku joka ei ehtinyt oppia mitään kunnollista ammattia ennen kuin maailma loppui, ja jonka on ollut pakko opetella selviytyminen kantapään kautta. Hänen sitkeytensä on **opittua, ei ammatillista** — hän osaa korjata portin koska on joutunut, ei koska tiesi ennestään. Tausta luetaan varusteista ylhäältä katsottuna, ei tekstistä: liian isoksi jäänyt takki tai huppari (ehkä jonkun muun, aiemman ihmisen), improvisoidut ja itse solmitut varusteet, kotitekoinen reppu. Ei taktista varustusta, ei aseasiantuntijan otetta. Kivääri on liian iso ja liian raskas hänelle — työkalu jota hän käyttää vastahakoisesti ja kömpelösti, ei jatke jota hän hallitsee.

### Persoona (2–3 lausetta)

Hän on sitkeä, mutta ei peloton — hän tekee mitä pitää tehdä koska vaihtoehtona on kuolla, ei koska hän nauttii siitä tai osaa sitä hyvin. Jokainen retki metsään on laskelmoitu riski jonka hän ottaa koska on pakko, ja jonka jälkeen hän palaa portille hieman rikkinäisempänä kuin lähti. Hänen rohkeutensa ei ole rohkeutta vaan vaihtoehtojen puutetta: ei julistuksia, ei nuoruuden röyhkeyttä, vaan yksi päivä lisää koska muuta ei ole.

### Miksi hän on yksin tässä tilanteessa

Suunnitteluperuste: yksinäisyys ei ole taustatarina, se on pelimekaniikka. Pelaaja ei koskaan saa apua jota hän ei itse hankki, eikä koskaan voi jakaa taakkaa. Yksi pari käsiä, yksi reppu, yksi valinta per päivä (ks. blueprint "The player should never be able to do everything in one day"). Se **miksi** hän on yksin jätetään tarkoituksella auki ja synkäksi: joku piti hänestä huolta ennen, ja nyt ei enää — peli ei selitä miten. Nuoruus terävöittää tämän: hän on liian nuori ollakseen yksin, ja on silti. Tämä palvelee sävyä (niukka, yksinäinen) rikkomatta cutscene-kieltoa. Art directionille: hahmon pitää näyttää ylhäältä katsottuna siltä että hän on ollut yksin jo jonkin aikaa — liike on jo asettunut varovaiseksi rutiiniksi, ei tuoretta paniikkia vaan opittua yksinäisyyttä.

### Mikä tekee hänestä kiinnostavan mutta ei ylisankarillisen

Kiinnostavuus tulee **haavoittuvuudesta, ei mahdista.** Hän voittaa kapealla marginaalilla tai häviää — hän ei koskaan jyrää yön yli. Pelaajan pitää tuntea että tämä nuori ihminen voisi kuolla tänä yönä, ja että hänen selviytymisensä on pelaajan valintojen ansiota, ei hahmon synnynnäisen kyvykkyyden. Kokemattomuus on osa panosta: hän ei ole varma tekemisestään, ja se näkyy. Design-vaatimus art directionille, ylhäältä kuvattuna: **vältä sankarisiluettia.** Ei leveää, tukevaa haara-asentoa joka täyttää ruudun; ei itsevarmaa, avointa asentoa. Sen sijaan ylhäältä luettava siluetti on **pieni ja kapea** — hartiat kapeat ja hieman kyyryssä, keho joka vie vähän tilaa, askellus varovaista ja kevyttä (valmis kääntymään ja pakenemaan yhtä nopeasti kuin etenemään). Liian iso takki ja liian iso ase korostavat kokoa: varusteet ovat isompia kuin hän. Hänen vahvuutensa on että hän on yhä pystyssä, ei että hän on vahva.

**Tuntuma-ankkuri (välittyy mekaniikan kautta, ei tekstin):** kun pelaaja polttaa illan viimeisen puun porttiin, sen pitää tuntua epätoivoiselta panokselta, ei voimannäytöltä. Hahmo on niin niukka kuin resurssitkin.

---

## 2. Zombityypit

### v0.1 — Hidas zombi (TOTEUTUKSESSA NYT)

**Rooli luupissa:** perusuhka, "seinä joka lähestyy". Yksittäisenä vaaraton, massana väistämätön. Se ei ole vihollinen jota vastaan taistellaan taidolla, vaan **aika joka lähestyy porttia** — pelaajan illan valmistelut ovat vetoa siitä kestääkö portti tämän hitaan mutta pysähtymättömän paineen.

**Visuaalinen luonnehdinta (art directionille, ylhäältä kuvattuna):** kulunut, hidas, raskas. Ei nopeaa uhkaa vaan väistämätöntä. Ylhäältä katsottuna uhka luetaan **liikkeestä ja siluetista**: askellus on nykivää ja epätahtista, epäinhimillisen kärsivällistä — se ei koskaan juokse, mutta se ei myöskään koskaan pysähdy, ja sen kulkusuunta on hitaan väistämättä kohti porttia. Siluetti ylhäältä: veltto, hieman vinossa roikkuva hartialinja, pää painunut, raajat epäsymmetrisesti. Massana ylhäältä ne muodostavat hitaasti tiivistyvän tumman laikun joka valuu porttia kohti. Ulkoasu: entinen tavallinen ihminen, vaatteet vielä osittain tunnistettavia ylhäältäkin (takin väri, työhaalari, arkivaate — naapuri, ohikulkija, joku joka oli ennen samanlainen kuin pelaaja). Tämä on tärkeä sävyvalinta: uhka ei ole hirviö vaan se mitä ihmisistä tuli. Väri kylmä, harmaa, veretön. Ei splatter-kauhua vaan hiljaista, väsynyttä kammottavuutta.

**Käyttäytyminen (pelituntuma):** massa yön yli, tasainen paine porttia vastaan. Yksi hidas zombi ei ole hetki, monta hidasta zombia on yö. Uhka on määrässä ja väistämättömyydessä, ei yllätyksessä.

### v0.2 — Tartuttajazombi / "infector" (SUUNNITTELUA NYT, TOTEUTUS v0.2)

**Rooli luupissa:** tuo pelin toisen paineakselin (ks. FEELS-LIKE-A-GAME §v0.2). Hidas zombi uhkaa **porttia** (akuutti, yöllinen). Tartuttaja uhkaa **hahmoa itseään** (hidas, kertyvä infektioajastin). Se muuttaa retkikohteen valinnan aidoksi: apteekki infektionhallintaan vai metsä yön puolustukseen.

**Visuaalinen luonnehdinta (art directionille, ylhäältä kuvattuna):** hidasta zombia sairaampi, väärempi. Koska kasvot eivät näy ylhäältä, tartunnan pitää lukea **siluetista, tekstuurista ja väristä ylhäältä**: turvonnut, pöhöttynyt hartia- ja selkälinja (leveämpi ja epämuotoisempi ylhäältä kuin hidas zombi), halkeileva tai kuoriutuva pinta, jotain mätää tai levinnyttä joka näkyy pään ja hartioiden yläpuolelta. Sen pitää näyttää siltä että pelkkä kosketus on vaarallinen, ei vain sen hampaat. Erottuva yhdellä silmäyksellä ylhäältä hitaasta zombista — eri siluetin muoto ja eri väri — jotta pelaaja lukee uhan tyypin heti: "tuo ei vain riko porttia, tuo tartuttaa minut." Väripaletti sama kylmä pohja mutta sairaalloinen vivahde (kellertävä, vihertävä, mätä), joka erottuu ylhäältä katsottunakin muusta massasta.

**Käyttäytyminen (suunnitteluperuste):** ei nopeampi vaan vaarallisempi kontaktissa. Sen uhka ei ole "murtaa portti nopeammin" vaan "muuttaa selviytyminen kalliimmaksi pitkällä aikavälillä". Tämä pitää v0.2:n paineen eri muotoisena, ei vain suurempana numerona.

### Spekulatiiviset tulevaisuuden zombityypit (EI TOTEUTUKSESSA — v0.6+ vaikeuskäyrää varten)

Nämä ovat **spekulatiivisia** ja tässä vain jotta assetpackin suunnittelu voi varata niille visuaalista tilaa. Ne EIVÄT ole hyväksyttyä scopea. v0.6 "7 yön MVP" tarvitsee vaikeuskäyrän (BACKLOG §v0.6), ja käyrä tarvitsee variaatiota uhassa. Kaksi ehdotusta:

**a) Ryntääjä (spekulatiivinen):** hidas zombi on aika, ryntääjä on **hetki**. Harvinainen, nopea, pakottaa pelaajan reagoimaan yhtäkkiä sen sijaan että vain valmistautuu etukäteen. Toisi yöhön piikin tasaisen paineen sekaan. Art direction-varaus (ylhäältä kuvattuna): laiha, kapea, jännittynyt siluetti joka erottuu ylhäältä pienempänä ja terävämpänä kuin muut; liikkeen rytmi päinvastainen kuin hitaalla — nopea, suoraviivainen syöksy jonka pelaaja lukee ylhäältä nopeasti liikkuvasta pisteestä. Sama kylmä paletti.

**b) Paksunahka / "murtaja" (spekulatiivinen):** hidas mutta kestävä, tehty erityisesti porttia vastaan. Tekee ammusten/puun taloudesta kireämmän myöhäisillä öillä. Art direction-varaus (ylhäältä kuvattuna): iso, leveä, massiivinen siluetti joka täyttää ylhäältä katsottuna selvästi enemmän tilaa kuin muut; panssaroituneen näköinen yläpuolelta (turvonnut selkä tai jätteeseen kuoriutunut kuori), liike raskasta ja horjumatonta. Luettavissa yhdellä silmäyksellä ylhäältä "tämä vie enemmän kuin muut".

**Merkintä:** a) ja b) ovat suunnittelijan ehdotuksia tulevaisuutta varten. Ne kuuluvat FEATURE-PARKING-LOT-henkeen: älä toteuta ennen kuin scope päivitetään. Ne ovat tässä vain assetpackin ennakointia varten.

---

## 3. NPC:t (SUUNNITTELUA NYT, TOTEUTUS v0.5)

Molemmat ovat v0.5-scopea (BACKLOG §v0.5, "lightweight NPCs"). Suunnitteluperuste (FEELS-LIKE §v0.5): NPC:t ovat **talousventtiileitä**, eivät RPG-hahmoja. Ne luovat päätöksiä muuttamatta peliä roolipeliksi — ei kysymysrataa, ei ystävyysmittaria, ei tarinaa. Sävylukko koskee heitäkin: kuluneita, epäluotettavan oloisia selviytyjiä, ei iloisia auttajia.

### Trader (kauppias)

**Rooli:** vaihda ylijäämäresurssi tarvittavaan (esim. liikaa puuta → ammuksia). Antaa pelaajalle venttiilin epätasapainoiseen looton, mutta hinnalla.

**Persoona/tuntuma (art directionille, ylhäältä kuvattuna):** ei ystävä. Selviytyjä joka on tehnyt kaupankäynnistä oman selviytymisstrategiansa. Laskelmoiva, varautunut, kohtelee pelaajaa kuin resurssia. Hänen läsnäolonsa pitää tuntua transaktiolta, ei kohtaamiselta — sävy on "hän auttaa sinua koska hän hyötyy siitä, ei koska välittää". Koska kasvot eivät näy ylhäältä, tuntuma luetaan siluetista ja varusteista: ylhäältä katsottuna hahmon ääriviivaa rikkovat kannetut tavarat — pussit, kääröt, roikkuvat kantamukset, leveä kuormitettu hartialinja. Erottuu pelaajasta selvästi tavaramääränsä takia. Asento kääntyilevä ja valpas, valmis lähtemään nopeasti. Ei uhkaava mutta ei lämmin. Kylmä, harkittu.

### Nurse (hoitaja)

**Rooli:** vaihtoehto lääkkeelle, hidastaa infektiota (BACKLOG §v0.5). Kytkeytyy v0.2:n infektioakseliin — antaa toisen tavan hallita infektiopainetta.

**Persoona/tuntuma (art directionille, ylhäältä kuvattuna):** väsynyt, ei pyhimys. Joku jolla oli terveydenhoidon taustaa ja joka nyt tekee mitä voi liian vähällä. Hänen apunsa on rajallista ja kulunutta — ei ihmelääkettä vaan hidastusta. Sävy: hän on nähnyt liikaa, hänen myötätuntonsa on kulunut ohueksi mutta ei loppuun. Koska kasvot eivät näy ylhäältä, rooli luetaan varusteista ja väristä: ylhäältä katsottuna jäänteitä hoitajan/lääkärin asusta (kulunut vaalea tai valkoinen takki, joka erottuu ympäristön harmaudesta juuri sen verran että rooli on tunnistettava), improvisoituja tarvikkeita mukana. Ei taktinen, ei kaupustelijan kuorma — hillitympi siluetti kuin traderilla. Ei toivon symboli vaan pieni, niukka helpotus synkkyyden keskellä.

**Suunnitteluvartio (molemmat NPC:t):** pidä kevyenä. Ei dialogipuita, ei kutscenejä, ei RPG-mekaniikkaa. NPC on käytännössä **valikko jolla on kasvot** — päätös, ei hahmokaari. Tämä suojaa CLAUDE.md hard rulea (ei tarinacutsceneja) ja FEELS-LIKE-varoitusta RPG-creepistä.

---

## 4. Base ja "the gate" — ympäristöhahmotelma

Tämä on **tunnelma- ja tuntumakuvaus** art directionille, ei tekninen spesifikaatio.

### The gate — portti

Portti on pelin sydän: se on ainoa asia pelaajan ja yön välissä, ja koko luuppi on vetoa siitä kestääkö se. Siksi portin pitää **näyttää siltä että se voisi murtua.** Ylhäältä kuvattuna portti on **este-viiva pelialueen reunalla** — kaistale jonka takaa massa valuu sisään. Ei linnoituksen portti vaan improvisoitu este: kasattua romua, naulattuja lankkuja, ruostunutta peltiä, autonovi, aitaelementtejä — asioita joita tavallinen ihminen sai käsiinsä ja löi yhteen epätoivossa. Ylhäältä katsottuna sen pitää lukeutua epätasaisena, paikkaillun näköisenä nauhana: eri-ikäistä puuta, päälle lyötyjä paikkoja, kohtia jotka on jo kerran murtuneet ja tilkitty.

**Tuntumavaatimus:** portin visuaalisen kunnon pitää lukea pelaajalle ilman numeroita, ylhäältä katsottuna. Ehjä portti on yhtenäinen, tiivis nauha — luja mutta karkea. Vaurioituessaan nauhaan ilmestyy ylhäältä näkyviä aukkoja ja murtumia: irtoavia lankkuja, reikiä joista pelialueen ulkopuolen pimeys näkyy läpi, kohtia joissa este ohenee. Pahiten vaurioitunut portti näyttää ylhäältä katkonaiselta, melkein läpäistävältä — seuraava isku voi olla viimeinen. Pelaajan pitää katsoa porttia ylhäältä ja tuntea "tämä ei kestä montaa yötä enää". Tämä on suora tuki ydintunteelle "selvisin juuri ja juuri".

### The base — tukikohta

Ei tukikohta sotilaallisessa mielessä. Yhden ihmisen viimeinen paikka: pieni, ahdas, väliaikaisen oloinen. Ylhäältä kuvattuna base on **pieni, tiivis lattia-alue** portin takana — ahtaus luetaan siitä miten vähän tilaa hahmolla on liikkua. Ei mukavuutta, ei runsautta. Muutama säilytetty resurssi näkyvissä lattialla ylhäältä (vähän ruokaa, kasa puuta, muutama patruuna) — niukkuuden pitää olla nähtävissä pelialueella, ei kätkettynä valikkoon. Ympäristö kertoo että täällä on eletty vähällä pitkään: kuluneita jälkiä, korjattuja asioita, ei koristeita.

**Valo ja aika:** kaksi vahvaa tunnelmatilaa jotka art directionin pitää erottaa selvästi:
- **Päivä/ilta:** kylmä, harmaa, väritön mutta turvallinen — hetki jolloin voi hengittää ja valita. Ei lämmin, mutta ei uhkaava.
- **Yö:** pimeä, ahdistava, hahmot ja portti vain osittain valaistuja. Yön pitää tuntua kohtaamiselta jota odotetaan pelolla. Valonlähde niukka (nuotio, taskulamppu, kuu) — pimeys on osa uhkaa.

**Kokonaissävy ympäristölle:** autioitunut, hiljainen, kylmä. Maailma joka oli ennen tavallinen ja on nyt tyhjä. Ei apokalypsin spektaakkelia (ei palavia kaupunkeja, ei dramaattista tuhoa) vaan hiljaista hylättyyttä — se on pahaenteisempää. Metsä (v0.1:n ainoa retkikohde) on sama sävy: ei satumetsä vaan harmaa, luutunut, paikka josta haetaan mitä on jäljellä ja josta palataan äkkiä ennen pimeää.

---

## Yhteenveto rooleista

| Hahmo/olento | Vaihe | Rooli yhdellä lauseella |
|---|---|---|
| Päähahmo ("Vahtija") | v0.1 | Nuori, kokematon mutta kantapään kautta karaistunut selviytyjä joka pitää yhtä porttia pystyssä yksi yö kerrallaan. |
| Hidas zombi | v0.1 | Väistämätön massa, "aika joka lähestyy porttia". |
| Tartuttajazombi | v0.2 | Toinen paineakseli — uhkaa hahmoa, ei vain porttia. |
| Ryntääjä (spekulatiivinen) | v0.6+ ehdotus | Harvinainen nopea piikki tasaisen paineen sekaan. |
| Murtaja (spekulatiivinen) | v0.6+ ehdotus | Kestävä, porttia vastaan tehty — kiristää resurssitaloutta. |
| Trader (kauppias) | v0.5 | Laskelmoiva vaihtoventtiili, ei ystävä. |
| Nurse (hoitaja) | v0.5 | Väsynyt, niukka helpotus infektiopaineeseen. |
| The gate | v0.1 | Improvisoitu este joka näyttää siltä että se voi murtua. |
| The base | v0.1 | Yhden ihmisen niukka, väliaikainen viimeinen paikka. |

Kaikki sävylukossa: synkkä, niukka, selviytymisjännite, ei sankarifantasiaa. Tavoite: **"selvisin juuri ja juuri. Yksi päivä lisää."**
