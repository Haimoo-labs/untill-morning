# Strateginen arvio ja go/no-go — Until Morning

**Rooli:** Athena (omistaja-agentti)
**Päivä:** 2026-07-07
**Tila:** Päätösdokumentti. Miranda (tuoteomistaja) ja Draper (markkinointi) käyttävät tätä lähtökohtana.
**Suositus lyhyesti:** **GO EHDOLLISESTI** — viimeistele prototyyppi, portita kaikki raha ennen "hauskuus"-todistetta.

---

## 0. Nykytila lyhyesti (mihin arvio perustuu)

- Suunnitteludokumentaatio on poikkeuksellisen kypsä: 24 md-tiedostoa (MVP-scope, build-plan, 3 ADR:ää, governance-malli, tehtävälistat, balance-taulukot, test-plan, DoD).
- Pelikoodi on käytännössä olematon: `game_state.gd` (25 riviä, pelkkä tilan runko) ja `main_controller.gd` (7 riviä, tulostaa "implement Prototype v0.1 next"). Yhteensä ~32 riviä GDScriptiä.
- **Johtopäätös:** projekti on suunnittelultaan pitkällä mutta toteutukseltaan lähtöviivalla. Ydinhypoteesia ("selvisin hädin tuskin, yksi päivä lisää") ei ole vielä testattu, koska pelattavaa luuppia ei ole.

Tämä epäsuhta on itsessään tärkein strateginen signaali: halpa osa (suunnittelu) on tehty ylikypsäksi, kallis ja riskillinen osa (pelattava, hauska, myytävä tuote) on tekemättä.

---

## 1. Markkina- ja genrekatsaus

**Genre:** mobiili zombie survival / base defense. Yksi mobiilin kestävimmistä ja täpötäysimmistä nicheistä.

Markkina jakautuu käytännössä kahteen arkkityyppiin:

1. **Monetisaatiovetoiset 4X/survival-RPG:t** — State of Survival (FunPlus), Last Day on Earth: Survival (Kefir), Doomsday: Last Survivors, Grim Soul, Dawn of Zombies. Hyvin rahoitettuja, aggressiivinen IAP/LiveOps, korkeat UA-budjetit. Tänne **ei kannata mennä** pienellä tiimillä — häviää pääomalle, ei designille.
2. **Sessiopohjaiset / arcade / design-vetoiset** — Into the Dead 2, Dead Ahead: Zombie Warfare, sekä laajemmin selviytymis-indie kuten This War of Mine (mobile), 60 Seconds!, ja day/night-luuppipelit (Loop Hero, Dome Keeper -henki). Tänne Until Morning **luontaisesti kuuluu**.

**Koon piirteet:** mobiilipelit ovat globaalisti kymmenien miljardien markkina, ja zombie/survival on evergreen-alaniche jolla on jatkuva kysyntä. Mutta: genren kyllästyneisyys tarkoittaa että **orgaaninen löydettävyys on lähes nolla** ilman selvää koukkua tai UA-panostusta. Markkina ei ole ongelma — erottuminen ja jakelu ovat.

---

## 2. Kohderyhmä ja differointi

**Kohderyhmä:** sessiopohjaisista selviytymis- ja roguelite-peleistä pitävät mobiilipelaajat, jotka haluavat tiukan päätöspelin lyhyissä pätkissä — eivät loputonta grindiä eivätkä maksumuuria. "Yksi päivä lisää" -tyyppi.

**Differointi (mikä tässä on aidosti erilaista):**

- **Design-vetoinen, ei monetisaatiovetoinen.** Repo kieltää eksplisiittisesti monetisaation ennen kuin peli on hauska. Tämä on genressä poikkeus ja uskottava erottautuja.
- **Tiukka päätösluuppi, ei resurssigrindi.** Ydinjännite on selkeä ja terävä: *käytänkö resurssit nyt vai riskeeraanko yön?* Push-your-luck + resurssienhallinta yhdessä session mitassa.
- **Offline, single-player, sessiopohjainen.** Ei tilejä, ei pilveä, ei pakotettua verkkoa (ainakin prototyypissä). Vähemmän kitkaa, vähemmän governance-riskiä.
- **Selkeä tunnelupaus:** "Loot by day. Build before dark. Survive until morning." + tavoitetunne "selvisin hädin tuskin". Tämä on myytävä koukku, jos toteutus lunastaa sen.

Differointi on olemassa ja uskottava. Se **ei ole vielä todistettu**, koska hauskuus elää tai kuolee pelituntumassa jota ei ole rakennettu.

---

## 3. Riskit

| # | Riski | Vakavuus | Huomio |
|---|-------|----------|--------|
| R1 | **Löydettävyys / jakelu.** Genre on täpötäysi; orgaaninen näkyvyys ~nolla ilman koukkua tai UA-rahaa. | Korkea | Tämä on kaupallisen menestyksen todellinen portti, ei tekninen toteutus. |
| R2 | **Toteutuskyky (pieni/yhden hengen tiimi).** ~32 riviä koodia vs. roadmap v0.6:een asti. Suunnittelun ja toteutuksen kuilu on iso. | Korkea | Riski että projekti jää ikuiseen suunnitteluvaiheeseen. Dokumentaatioon on jo yliInvestoitu ennen ensimmäistä pelattavaa ruutua. |
| R3 | **Hauskuus todistamatta.** Ydinhypoteesia ei ole testattu. Koko arvo lepää sen varassa. | Korkea | Halpa ja nopea todistaa/kumota — siksi tämä on ensimmäinen portti. |
| R4 | **Taide ja ääni puuttuvat.** Vain placeholder. Mobiilissa store-listauksen konversio ratkeaa pitkälti taiteella. | Keskisuuri | Kallis ja aikaa vievä osa; siirretään portin taakse. |
| R5 | **Monetisaatiomalli validoimatta.** Sessiopohjainen single-player on mobiilissa vaikea monetisoida (premium kuollut Androidilla; ads/IAP vaatii retention-koukut joita design ei vielä sisällä). | Keskisuuri | Oikein siirretty myöhemmäksi, mutta liiketoimintamalli on aito avoin kysymys. |
| R6 | **Scope-ajautuminen.** Roadmap ulottuu v0.6:een (infektio, sää, NPC:t, 7 yötä) ennen kuin v0.1 on pelattava. | Keskisuuri | Hard rules ja parking lot hillitsevät tätä hyvin — hyvä hallintakeino jo olemassa. |

Positiivista riskienhallinnassa: repon oma governance (hard rules, feature parking lot, "älä lisää ennen kuin luuppi pelattava", monetisaatio erillisen omistajahyväksynnän takana) osoittaa kurinalaista scope-ajattelua. Se pienentää R6:ta merkittävästi.

---

## 4. Resurssitarve (karkea)

Nämä ovat suuruusluokka-arvioita päätöksentekoa varten, eivät sitovia estimaatteja.

**Vaihe A — Prototyypin v0.1 viimeistely (3 yötä pelattava, placeholder-taide):**
- Tehtävät ovat jo pilkottu ja spesifioitu (single scene, GDScript, tehtävälista valmis).
- Suuruusluokka: **~40–80 tuntia** osaavalta Godot-kehittäjältä (n. 1 keskittynyt työviikko tai 2–4 osa-aikaista viikkoa).
- Rahakustannus: ~nolla. Vain aikaa.

**Vaihe B — "Hauskuus-validoitu" 7 yön MVP (v0.6, sisäinen pelattava build):**
- Lisää infektio, lootvalinta, sää, kevyet NPC:t, vaikeuskäyrä, balanssi.
- Suuruusluokka: **~3–6 kuukautta osa-aikaista** kehitystä.
- Rahakustannus: pieni, jos taide pysyy placeholderina.

**Vaihe C — Tuotteistus (store-valmis julkaisu):**
- Taide- ja äänipassi, UI-viimeistely, Android-export + allekirjoitus, store-assetit, monetisaatiodesign, soft launch, mahdollinen LiveOps.
- Suuruusluokka: **6–12+ kuukautta** ja/tai budjetti ulkoistettuun taiteeseen/ääneen (karkeasti muutamia tuhansia – kymmeniä tuhansia € scopesta riippuen).
- **UA/markkinointi on todellinen kallis portti:** CPI-testaus ja hankinta maksavat tuhansista kymmeniin tuhansiin ennen kuin tiedetään konvertoituuko peli. Tämä on suurin yksittäinen rahasitoumus.

**Tulkinta:** Vaihe A on halpa ja nopea. Vaiheet B ja C ovat kalliita ja riskillisiä. Päätöksen pitää portittaa raha B/C:hen, ei A:han.

---

## 5. Suositus: GO EHDOLLISESTI

**Päätös: GO EHDOLLISESTI.** Viimeistele prototyyppi. Älä sitoudu tuotteistukseen, taiteeseen, monetisaatioon tai markkinointiin ennen kuin hauskuus-portti on läpäisty.

**Perustelut:**

1. **Riskin ja tuoton suhde on erinomainen tässä portissa.** Ydinhypoteesin ("yksi päivä lisää") todistaminen tai kumoaminen maksaa viikkoja ja ~nolla euroa. Design on poikkeuksellisen harkittu ja tehtävät valmiiksi pilkottu. Halvan, korkean optionaalisuuden kokeen tappaminen nyt olisi arvon tuhoamista.
2. **Kalliit ja epävarmat osat ovat portin takana.** Genren kyllästyneisyys (R1), taide (R4) ja monetisaatio (R5) ovat todellisia, mutta ne kaikki tulevat maksettaviksi vasta hauskuuden jälkeen. Ei ole mitään syytä maksaa niitä ennen kuin ydinluuppi on todistettu.
3. **Kuri on jo olemassa, kyvykkyys ei vielä.** Repon governance hillitsee scope-ajautumista uskottavasti (R6 pieni). Suurin avoin kysymys ei ole "onko suunnitelma hyvä" vaan "syntyykö pelattava, hauska luuppi" — ja se ratkeaa vain rakentamalla se.

**Miksi ei NO-GO:** kokeen kustannus on murto-osa sen informaatioarvosta. Ei ole omistajan tehtävä tappaa halpaa, hyvin pohjustettua koetta.

**Miksi ei ehdoton GO:** genren saturaatio + todistamaton hauskuus + validoimaton monetisaatio tekevät täydestä tuotteistus- ja markkinointisitoumuksesta ennenaikaisen ja holtittoman.

### Ehdot (portit)

- **Portti 1 — Pelattavuus:** v0.1 pelattava alusta loppuun (3 yötä, morning report, game over / prototype complete). Läpäisy: build aukeaa, luuppi pyörii, DoD täyttyy.
- **Portti 2 — Hauskuus:** sisäinen pelitesti tavoitetunnetta ("selvisin hädin tuskin, yksi päivä lisää") vasten. Läpäisy: testaajat haluavat pelata "yhden päivän lisää" ilman kehotusta. **Tämän portin omistaa ihminen + Miranda.** Jos ei läpäise → pivot luuppiin tai NO-GO, ei rahaa eteenpäin.
- **Portti 3 — Raha/riski (STOP):** mikään taide-, ääni-, monetisaatio- tai markkinointi-/UA-panostus ei käynnisty ennen kuin Portit 1 ja 2 ovat läpi ja ihminen on erikseen hyväksynyt. Monetisaatio pysyy repon säännön mukaisesti erillisen omistajahyväksynnän takana.

### Eskalointi ihmiselle (arvopohjainen kysymys)

Yksi kysymys ylittää agentin valtuudet ja ratkaisee kuinka ankarasti R1/R5 painavat: **onko tavoite kaupallinen tuloprojekti vai portfolio-/oppimisprojekti?**
- Jos **oppimis-/portfolio** → rima on matala, GO on selvä, löydettävyys ja monetisaatio eivät ole esteitä.
- Jos **kaupallinen tulo** → löydettävyys (R1) ja monetisaatiomalli (R5) ovat vakavia, ja ne vaativat oman suunnitelman **ennen** vaiheiden B/C rahoitusta.
Tämä valinta kuuluu ihmiselle; se ei muuta Portin 1 päätöstä (viimeistele prototyyppi joka tapauksessa), mutta se määrittää mitä Portin 2 jälkeen tavoitellaan.

---

## 6. Suositeltu seuraava askel

1. **Valtuuta Miranda (tuoteomistaja)** viemään v0.1 pelattavaksi olemassa olevan tehtävälistan pohjalta ja määrittelemään Portin 2 hauskuus-testin konkreettiset läpäisykriteerit. Tämä on ainoa askel joka käynnistyy nyt.
2. **Draper (markkinointi) odottaa Portti 2:ta.** Ei go-to-market-panostusta, ei UA-budjettia, ei monetisaatiotyötä ennen hauskuus-portin läpäisyä. Draper voi valmiiksi hahmottaa asemoinnin (design-vetoinen sessioselviytyjä vs. 4X-grindi) ilman rahasitoumusta.
3. **Nosta ihmiselle** yllä oleva arvopohjainen kysymys (kaupallinen vs. portfolio), jotta Portin 2 jälkeinen suunta on selvä ennen kuin sinne tullaan.

---

## Päätösloki

| Kenttä | Sisältö |
|--------|---------|
| Päätös | GO EHDOLLISESTI — viimeistele prototyyppi; raha portitettu |
| Tekijä | Athena (omistaja-agentti), 2026-07-07 |
| Hyväksytty riski | Tietoisesti hyväksytään toteutuskyvyn (R2) ja hauskuuden todistamattomuuden (R3) riski Vaiheessa A, koska kustannus on viikkoja ja ~0 €. Nämä ratkaistaan portittamalla, ei välttämällä. |
| Hylätty vaihtoehto 1 | Ehdoton GO — hylätty: sitoisi kalliin tuotteistuksen/markkinoinnin ennen hauskuus- ja monetisaatiotodistetta. |
| Hylätty vaihtoehto 2 | NO-GO — hylätty: tappaisi halvan, hyvin pohjustetun kokeen jonka informaatioarvo ylittää kustannuksen moninkertaisesti. |
| Delegointi | Miranda: v0.1 pelattavaksi + Portti 2:n kriteerit. Draper: odottaa Porttia 2, ei rahaa. Ihminen: päättää kaupallinen vs. portfolio -suunnan ja hyväksyy Portti 3:n. |
| Ehdot | Portti 1 (pelattava) → Portti 2 (hauska) → Portti 3 (raha, ihmisen hyväksyntä). Mikään panostus taiteeseen/ääneen/monetisaatioon/UA:han ei käynnisty ennen Portti 3:a. |
