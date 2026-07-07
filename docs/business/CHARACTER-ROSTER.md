# Character Roster — Until Morning

**Rooli:** Ludo (pelisuunnittelija)
**Päivä:** 2026-07-07
**Tila:** Suunnittelu- ja hahmospesifikaatio. EI koodia, EI kuvia, EI kuvagenerointi-promptteja, EI teknistä asset-formaattia. Ristiviittaa: `docs/game-design-blueprint.md`, `docs/mvp-scope.md`, `docs/product/BACKLOG.md`, `docs/product/FEATURE-PARKING-LOT.md`, `docs/business/FEELS-LIKE-A-GAME-MILESTONE.md`.

## Tarkoitus ja rajaus

Tämä dokumentti kuvaa Until Morningin hahmoroosterin **kuka–mitä–miksi–tuntuma** -tasolla. Se on syöte art directionille (Frida), joka muuttaa nämä kuvausvaraukset kuvageneraatio-aihioiksi. En kirjoita itse kuvausvaraushakuja enkä teknisiä asset-tietoja: se on toinen rooli.

Tietoinen poikkeus normaalista Portti-järjestyksestä: taide kuuluisi vasta Porttiin 3, mutta omistaja on hyväksynyt tämän suunnittelutyön rinnalle nyt. Tämä on **vain spesifikaatiota**, ei koodiin tai peliin vietävää sisältöä.

### Sävylukko (kaikkia hahmoja koskee)

Synkkä, niukka, selviytymisjännite. **Ei sankarifantasiaa.** Tavoiteltu tunne on "selvisin juuri ja juuri. Yksi päivä lisää." Jokaisen hahmon pitää näyttää kuluneelta, ei kiillotetulta: väsymys, ryppyisyys, korjatut vaatteet, kylmä valo. Kukaan ei ole voittaja, kaikki ovat kestäneet toistaiseksi.

### v0.1 hard rule: hahmo välittyy ilman sanoja

CLAUDE.md kieltää tarinacutscenet ja v0.1:ssä ei ole dialogia. Siksi **päähahmo ei saa persoonaansa tekstistä vaan ainoastaan visuaalisesti ja pelimekaniikan kautta.** Design-ohje art directionille: kaikki mitä hahmosta pitää tietää, on luettava yhdestä hahmokuvasta ja siitä miltä tekeminen tuntuu. Ei nimikylttejä pelissä, ei taustatarinaa ruudulla. Nimet ja taustat tässä dokumentissa ovat suunnittelijan ja taiteilijan työkaluja, eivät pelaajalle näytettävää tekstiä.

---

## 1. Päähahmo — pelattava selviytyjä

### Arkkityyppi

**"Vahtija".** Ei sotilas, ei sankari, ei valittu. Tavallinen ihminen joka sattui jäämään henkiin ja jonka koko olemassaolo on kutistunut yhteen tehtävään: pitää tämä yksi portti pystyssä yksi yö kerrallaan. v0.1-tasolla nimi ei ole tarpeen — hahmo tunnetaan siitä mitä hän tekee, ei siitä kuka hän on.

### Ikä ja tausta-vihje

Keski-ikäinen, arviolta 40–50. Tarpeeksi vanha että liikkeissä on varovaisuutta ja väsymystä, ei nuoruuden röyhkeyttä. Tausta luetaan vaatteista ja varusteista, ei tekstistä: haalarit tai työtakki, kuluneet saappaat, itse korjattu reppu, jokin joka vihjaa entiseen tavalliseen elämään (talonmies, metsuri, varastotyöntekijä — joku joka osasi jo ennen kriisiä korjata ja kantaa). Ei taktista varustusta, ei aseasiantuntijan ilmettä. Kivääri on työkalu jota hän käyttää vastahakoisesti, ei jatke jota hän hallitsee.

### Persoona (2–3 lausetta)

Hän on sitkeä, mutta ei peloton — hän tekee mitä pitää tehdä koska vaihtoehtona on kuolla, ei koska hän nauttii siitä. Jokainen retki metsään on laskelmoitu riski jonka hän ottaa hampaat irvessä ja jonka jälkeen hän palaa portille hieman kuluneempana. Hänen rohkeutensa on arkista ja väsynyttä: ei julistuksia, vaan yksi päivä lisää.

### Miksi hän on yksin tässä tilanteessa

Suunnitteluperuste: yksinäisyys ei ole taustatarina, se on pelimekaniikka. Pelaaja ei koskaan saa apua jota hän ei itse hankki, eikä koskaan voi jakaa taakkaa. Yksi pari käsiä, yksi reppu, yksi valinta per päivä (ks. blueprint "The player should never be able to do everything in one day"). Se **miksi** hän on yksin jätetään tarkoituksella auki ja synkäksi: muut ovat menneet, ja peli ei selitä miten. Tämä palvelee sävyä (niukka, yksinäinen) rikkomatta cutscene-kieltoa. Art directionille: hahmon pitää näyttää siltä että hän on ollut yksin jo jonkin aikaa — ei tuoretta paniikkia, vaan asettunutta yksinäisyyttä.

### Mikä tekee hänestä kiinnostavan mutta ei ylisankarillisen

Kiinnostavuus tulee **haavoittuvuudesta, ei mahdista.** Hän voittaa kapealla marginaalilla tai häviää — hän ei koskaan jyrää yön yli. Pelaajan pitää tuntea että tämä ihminen voisi kuolla tänä yönä, ja että hänen selviytymisensä on pelaajan valintojen ansiota, ei hahmon synnynnäisen kyvykkyyden. Design-vaatimus art directionille: **vältä sankariposeja.** Ei leveää haara-asentoa, ei itsevarmaa katsetta kohti horisonttia, ei lihaksia. Sen sijaan: hartiat hieman kumarassa, katse valpas ja väsynyt, keho joka on valmis pakenemaan yhtä paljon kuin taistelemaan. Hänen vahvuutensa on että hän on yhä pystyssä, ei että hän on vahva.

**Tuntuma-ankkuri (välittyy mekaniikan kautta, ei tekstin):** kun pelaaja polttaa illan viimeisen puun porttiin, sen pitää tuntua epätoivoiselta panokselta, ei voimannäytöltä. Hahmo on niin niukka kuin resurssitkin.

---

## 2. Zombityypit

### v0.1 — Hidas zombi (TOTEUTUKSESSA NYT)

**Rooli luupissa:** perusuhka, "seinä joka lähestyy". Yksittäisenä vaaraton, massana väistämätön. Se ei ole vihollinen jota vastaan taistellaan taidolla, vaan **aika joka lähestyy porttia** — pelaajan illan valmistelut ovat vetoa siitä kestääkö portti tämän hitaan mutta pysähtymättömän paineen.

**Visuaalinen luonnehdinta (art directionille):** kulunut, hidas, raskas. Ei nopeaa uhkaa vaan väistämätöntä. Liikkeen pitää olla nykivää, epäinhimillisen kärsivällistä — se ei koskaan juokse, mutta se ei myöskään koskaan pysähdy. Ulkoasu: entinen tavallinen ihminen, vaatteet vielä osittain tunnistettavia (naapuri, ohikulkija, joku joka oli ennen samanlainen kuin pelaaja). Tämä on tärkeä sävyvalinta: uhka ei ole hirviö vaan se mitä ihmisistä tuli. Väri kylmä, harmaa, veretön. Ei splatter-kauhua vaan hiljaista, väsynyttä kammottavuutta.

**Käyttäytyminen (pelituntuma):** massa yön yli, tasainen paine porttia vastaan. Yksi hidas zombi ei ole hetki, monta hidasta zombia on yö. Uhka on määrässä ja väistämättömyydessä, ei yllätyksessä.

### v0.2 — Tartuttajazombi / "infector" (SUUNNITTELUA NYT, TOTEUTUS v0.2)

**Rooli luupissa:** tuo pelin toisen paineakselin (ks. FEELS-LIKE-A-GAME §v0.2). Hidas zombi uhkaa **porttia** (akuutti, yöllinen). Tartuttaja uhkaa **hahmoa itseään** (hidas, kertyvä infektioajastin). Se muuttaa retkikohteen valinnan aidoksi: apteekki infektionhallintaan vai metsä yön puolustukseen.

**Visuaalinen luonnehdinta (art directionille):** hidasta zombia sairaampi, väärempi. Jokin sen olemuksessa vihjaa tartuntaan — turvonnut, halkeileva, jotain mätää tai levinnyttä. Sen pitää näyttää siltä että pelkkä kosketus on vaarallinen, ei vain sen hampaat. Erottuva sillmäyksellä hitaasta zombista, jotta pelaaja lukee uhan tyypin heti: "tuo ei vain riko porttia, tuo tartuttaa minut." Väripaletti sama kylmä pohja mutta sairaalloinen vivahde (kellertävä, vihertävä, mätä).

**Käyttäytyminen (suunnitteluperuste):** ei nopeampi vaan vaarallisempi kontaktissa. Sen uhka ei ole "murtaa portti nopeammin" vaan "muuttaa selviytyminen kalliimmaksi pitkällä aikavälillä". Tämä pitää v0.2:n paineen eri muotoisena, ei vain suurempana numerona.

### Spekulatiiviset tulevaisuuden zombityypit (EI TOTEUTUKSESSA — v0.6+ vaikeuskäyrää varten)

Nämä ovat **spekulatiivisia** ja tässä vain jotta assetpackin suunnittelu voi varata niille visuaalista tilaa. Ne EIVÄT ole hyväksyttyä scopea. v0.6 "7 yön MVP" tarvitsee vaikeuskäyrän (BACKLOG §v0.6), ja käyrä tarvitsee variaatiota uhassa. Kaksi ehdotusta:

**a) Ryntääjä (spekulatiivinen):** hidas zombi on aika, ryntääjä on **hetki**. Harvinainen, nopea, pakottaa pelaajan reagoimaan yhtäkkiä sen sijaan että vain valmistautuu etukäteen. Toisi yöhön piikin tasaisen paineen sekaan. Art direction-varaus: laihempi, jännittyneempi, repivämpi silhuetti — kaikki sama kylmä paletti mutta liike päinvastainen kuin hitaalla.

**b) Paksunahka / "murtaja" (spekulatiivinen):** hidas mutta kestävä, tehty erityisesti porttia vastaan. Tekee ammusten/puun taloudesta kireämmän myöhäisillä öillä. Art direction-varaus: massiivisempi, panssaroituneen näköinen (turvonnut tai jätteeseen kuoriutunut), luettavissa "tämä vie enemmän kuin muut".

**Merkintä:** a) ja b) ovat suunnittelijan ehdotuksia tulevaisuutta varten. Ne kuuluvat FEATURE-PARKING-LOT-henkeen: älä toteuta ennen kuin scope päivitetään. Ne ovat tässä vain assetpackin ennakointia varten.

---

## 3. NPC:t (SUUNNITTELUA NYT, TOTEUTUS v0.5)

Molemmat ovat v0.5-scopea (BACKLOG §v0.5, "lightweight NPCs"). Suunnitteluperuste (FEELS-LIKE §v0.5): NPC:t ovat **talousventtiileitä**, eivät RPG-hahmoja. Ne luovat päätöksiä muuttamatta peliä roolipeliksi — ei kysymysrataa, ei ystävyysmittaria, ei tarinaa. Sävylukko koskee heitäkin: kuluneita, epäluotettavan oloisia selviytyjiä, ei iloisia auttajia.

### Trader (kauppias)

**Rooli:** vaihda ylijäämäresurssi tarvittavaan (esim. liikaa puuta → ammuksia). Antaa pelaajalle venttiilin epätasapainoiseen looton, mutta hinnalla.

**Persoona/tuntuma (art directionille):** ei ystävä. Selviytyjä joka on tehnyt kaupankäynnistä oman selviytymisstrategiansa. Laskelmoiva, varautunut, katsoo pelaajaa kuin resurssia. Hänen läsnäolonsa pitää tuntua transaktiolta, ei kohtaamiselta — sävy on "hän auttaa sinua koska hän hyötyy siitä, ei koska välittää". Ulkoasu: kantaa tavaraa, monta taskua/pussia, tarkkaavainen katse, keho joka on valmis lähtemään nopeasti. Ei uhkaava mutta ei lämmin. Kylmä, harkittu.

### Nurse (hoitaja)

**Rooli:** vaihtoehto lääkkeelle, hidastaa infektiota (BACKLOG §v0.5). Kytkeytyy v0.2:n infektioakseliin — antaa toisen tavan hallita infektiopainetta.

**Persoona/tuntuma (art directionille):** väsynyt, ei pyhimys. Joku jolla oli terveydenhoidon taustaa ja joka nyt tekee mitä voi liian vähällä. Hänen apunsa on rajallista ja kulunutta — ei ihmelääkettä vaan hidastusta. Sävy: hän on nähnyt liikaa, hänen myötätuntonsa on kulunut ohueksi mutta ei loppuun. Ulkoasu: jäänteitä hoitajan/lääkärin varustuksesta (kulunut takki, improvisoidut tarvikkeet), väsyneet silmät, kädet jotka ovat tehneet paljon. Ei toivon symboli vaan pieni, niukka helpotus synkkyyden keskellä.

**Suunnitteluvartio (molemmat NPC:t):** pidä kevyenä. Ei dialogipuita, ei kutscenejä, ei RPG-mekaniikkaa. NPC on käytännössä **valikko jolla on kasvot** — päätös, ei hahmokaari. Tämä suojaa CLAUDE.md hard rulea (ei tarinacutsceneja) ja FEELS-LIKE-varoitusta RPG-creepistä.

---

## 4. Base ja "the gate" — ympäristöhahmotelma

Tämä on **tunnelma- ja tuntumakuvaus** art directionille, ei tekninen spesifikaatio.

### The gate — portti

Portti on pelin sydän: se on ainoa asia pelaajan ja yön välissä, ja koko luuppi on vetoa siitä kestääkö se. Siksi portin pitää **näyttää siltä että se voisi murtua.** Ei linnoituksen portti vaan improvisoitu este: kasattua romua, naulattuja lankkuja, ruostunutta peltiä, autonovi, aitaelementtejä — asioita joita tavallinen ihminen sai käsiinsä ja löi yhteen epätoivossa. Sen pitää kertoa tarina korjaamisesta: päälle lyötyjä paikkoja, eri-ikäistä puuta, kohtia jotka on jo kerran murtuneet ja tilkitty.

**Tuntumavaatimus:** portin visuaalisen kunnon pitää lukea pelaajalle ilman numeroita. Ehjä portti näyttää lujalta mutta karkealta. Vaurioitunut portti näyttää siltä että seuraava isku voi olla viimeinen — halkeamia, riippuvia lankkuja, läpi näkyvää pimeyttä. Pelaajan pitää katsoa porttia ja tuntea "tämä ei kestä montaa yötä enää". Tämä on suora tuki ydintunteelle "selvisin juuri ja juuri".

### The base — tukikohta

Ei tukikohta sotilaallisessa mielessä. Yhden ihmisen viimeinen paikka: pieni, ahdas, väliaikaisen oloinen. Ei mukavuutta, ei runsautta. Muutama säilytetty resurssi näkyvissä (vähän ruokaa, kasa puuta, muutama patruuna) — niukkuuden pitää olla nähtävissä, ei kätkettynä valikkoon. Ympäristö kertoo että täällä on eletty vähällä pitkään: kuluneita jälkiä, korjattuja asioita, ei koristeita.

**Valo ja aika:** kaksi vahvaa tunnelmatilaa jotka art directionin pitää erottaa selvästi:
- **Päivä/ilta:** kylmä, harmaa, väritön mutta turvallinen — hetki jolloin voi hengittää ja valita. Ei lämmin, mutta ei uhkaava.
- **Yö:** pimeä, ahdistava, hahmot ja portti vain osittain valaistuja. Yön pitää tuntua kohtaamiselta jota odotetaan pelolla. Valonlähde niukka (nuotio, taskulamppu, kuu) — pimeys on osa uhkaa.

**Kokonaissävy ympäristölle:** autioitunut, hiljainen, kylmä. Maailma joka oli ennen tavallinen ja on nyt tyhjä. Ei apokalypsin spektaakkelia (ei palavia kaupunkeja, ei dramaattista tuhoa) vaan hiljaista hylättyyttä — se on pahaenteisempää. Metsä (v0.1:n ainoa retkikohde) on sama sävy: ei satumetsä vaan harmaa, luutunut, paikka josta haetaan mitä on jäljellä ja josta palataan äkkiä ennen pimeää.

---

## Yhteenveto rooleista

| Hahmo/olento | Vaihe | Rooli yhdellä lauseella |
|---|---|---|
| Päähahmo ("Vahtija") | v0.1 | Tavallinen, väsynyt selviytyjä joka pitää yhtä porttia pystyssä yksi yö kerrallaan. |
| Hidas zombi | v0.1 | Väistämätön massa, "aika joka lähestyy porttia". |
| Tartuttajazombi | v0.2 | Toinen paineakseli — uhkaa hahmoa, ei vain porttia. |
| Ryntääjä (spekulatiivinen) | v0.6+ ehdotus | Harvinainen nopea piikki tasaisen paineen sekaan. |
| Murtaja (spekulatiivinen) | v0.6+ ehdotus | Kestävä, porttia vastaan tehty — kiristää resurssitaloutta. |
| Trader (kauppias) | v0.5 | Laskelmoiva vaihtoventtiili, ei ystävä. |
| Nurse (hoitaja) | v0.5 | Väsynyt, niukka helpotus infektiopaineeseen. |
| The gate | v0.1 | Improvisoitu este joka näyttää siltä että se voi murtua. |
| The base | v0.1 | Yhden ihmisen niukka, väliaikainen viimeinen paikka. |

Kaikki sävylukossa: synkkä, niukka, selviytymisjännite, ei sankarifantasiaa. Tavoite: **"selvisin juuri ja juuri. Yksi päivä lisää."**
