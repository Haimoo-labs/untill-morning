# Scope- ja ohjausdokumenttien right-sizing -suositus — Until Morning

**Rooli:** Gantt (projektipäällikkö)
**Päivä:** 2026-07-07
**Tila:** Suositusdokumentti. EI muuta mitään olemassa olevaa tiedostoa. Käyttäjä hyväksyy tai hylkää ennen kuin kukaan koskee dokumentteihin.
**Kohde:** roadmap-realistisuus, governance-kansion oikea mitoitus, ohjaus-/steering-dokumenttien päällekkäisyydet.

---

## Tiivistys (lue tämä ensin)

Sama kaava jonka CLAUDE.md:n katselmointi paljasti koodiohjeissa toistuu **scope- ja ohjausdokumenteissa, mutta pahempana**. Konkreettinen mittari:

- **330 riviä** GDScriptiä koko pelissä (Task 001–002 tehtynä).
- **3853 riviä** dokumentaatiota (28 md-tiedostoa).
- Pelkkä `docs/governance/` + `docs/templates/` = **1150 riviä**, eli **3,5× koko pelin koodimäärä**.

Athenan strategia-arvio nimesi tämän jo tärkeimmäksi signaaliksi: *"halpa osa (suunnittelu) on tehty ylikypsäksi, kallis osa (pelattava tuote) on tekemättä."* Governance-koneisto on osa tuota yli-investointia.

**Tärkeää erottelu:** ongelma ei ole että governancea on olemassa. Repo kutsuu itseään oikein "Governance Light" -malliksi, ja kevyt kuri on aidosti pitänyt scopen kurissa (parking lot, hard rules). Ongelma on **volyymi, päällekkäisyys ja ennenaikaisuus**: ~1150 riviä prosessia yhden hengen prototyypille, sama kieltolista kuudessa paikassa, ja tuotanto-/maksu-/mainos-incidenttikoneisto pelille jolla on nolla käyttäjää ja nolla julkaistua buildia. Oikea mitoitus on noin **kolmasosa** nykyisestä.

---

## 1. Roadmapin realistisuus (v0.1 → v0.6 ja tahditus)

**Verdikti: roadmap ja tahditus ovat realistisia. Ei ilmeistä yli- eikä ali-mitoitusta itse pelisuunnitelmassa. Yli-mitoitus on ohjauskoneistossa, ei roadmapissa.**

- **Aikatauluarviot ovat rehellisiä ja keskenään linjassa.** MVP-FAST-TRACK antaa ~13–20 h puhdasta työtä + puskuri → ~18–26 h Portti 1:een. Strategia-arvio antaa Vaihe A:lle 40–80 h (kattaa ympäristön + iteroinnin), Vaihe B:lle (v0.6) 3–6 kk osa-aikaista, Vaihe C:lle 6–12+ kk. Dokumentit **selittävät eron eksplisiittisesti** (kapea koodipolku vs. laajempi iterointi), eivät valehtele. Tämä on hyvää projektinhallintaa.
- **Nykytila vahvistaa arvion.** Task 001–004 on tehty ja pushattu (7aa0226). Jäljellä on 003 (testiraportti) ja 005 (completion report). Kriittisen polun ainoa oikea blokkeri on tunnistettu oikein: **Task 003 vaatii oikean Godot-ajon + ihmisen joka klikkaa TC-001…010** (riski R1 / R-P3). Se on ympäristöriippuvuus, ei koodiriippuvuus — suurin aikatauluriski, ja se on jo nostettu ajoissa. Ei piiloon jäänyttä riskiä.
- **Vaiheistus on kaupallisesti oikein priorisoitu.** Syvyys (v0.2 infektio, v0.3 loot-valinta) ennen vaihtelua (v0.4 sää). Sää on nimetty ensimmäiseksi slimmattavaksi jos yhden hengen kapasiteetti (R-P1) kiristää. Tämä on juuri se jousto jonka yhden hengen projekti tarvitsee.
- **Scope-kuri roadmapissa on kunnossa.** "Do not build ennen v0.6", "Never without approval", parking lot. R6 (scope creep) on perustellusti arvioitu matalaksi.

**Ainoa realistisuushuomio:** roadmap ei ole yli-mitoitettu, mutta se on **kirjoitettu kolmeen kertaan** (ks. kohta 3). Se ei uhkaa aikataulua, mutta se on ylläpitovelka: kolme paikkaa jotka voivat ajautua eri suuntiin.

---

## 2. Governance-kansion right-sizing (a=poista, b=tiivistä, c=lykkää)

Arvio per tiedosto. "Load-bearing" = jokin muu dokumentti oikeasti viittaa siihen ja käyttää sitä.

| Tiedosto | Rivit | Tuottaako arvoa NYT? | Verdikti |
|---|---:|---|---|
| `GOVERNANCE.md` | 131 | Osin. "Governance Light" -kehys on hyödyllinen, mutta toistaa R0–R5-yhteenvedon ja canonical-listan muualta. | **(b) Tiivistä** → sulautetaan yhteen kevyeen tiedostoon. |
| `DOCUMENTATION-STANDARD.md` | 206 | Ei juuri. Dokumentti joka kertoo miten dokumentteja kirjoitetaan ja listaa mitä kunkin canonical-tiedoston pitää sisältää — sisällön jonka tiedostot jo sisältävät. Puhtainta prosessiteatteria yhden hengen repossa. | **(a) Poista** (tai kutista ~10 rivin nimeämis-/sijaintisäännöksi light-tiedostoon). |
| `VERSIONING.md` | 158 | Kyllä, mutta laimennettuna. `Prototype vX.Y` -formaatti ja 0.x.y-buildinumerointi ovat aidosti käytössä ja hyödyllisiä. Loput 140 riviä on esimerkkejä ja "älä käytä 1.0.0 vielä". | **(b) Tiivistä** → ~15 riviä (formaatti + bump-säännöt) light-tiedostoon. |
| `CHANGE-CONTROL.md` | 214 | Osin, load-bearing. R0–R5-riskiluokat ja Claude Code -taskiformaatti ovat käytössä (DoD, GOVERNANCE, templatet viittaavat). Mutta branch-nimeäminen ja commit-viestikonventiot ovat geneeristä "hyvä kehittäjä tekee näin" -täytettä — sama laji jarru jonka CLAUDE.md-katselmointi jo poisti. | **(b) Tiivistä** → säilytä R0–R5 + taskiformaatti, pudota geneeriset osat. |
| `INCIDENT-MANAGEMENT.md` | 191 | Ei nyt. SEV-1/SEV-2 kuvaavat julkisia käyttäjiä, store-julkaisuja, maksuja, mainoksia, vuotaneita salaisuuksia, postmortemeja — tapahtumia jotka **eivät voi tapahtua** nollan käyttäjän ja nollan buildin prototyypissä. SEV-3/SEV-4 ("projekti ei aukea") mahtuu yhteen kappaleeseen. | **(c) Lykkää** → arkistoi `governance/deferred/`-kansioon, aktivoi Portti 3:ssa / Android-testauksessa. Jätä light-tiedostoon 2 riviä: "prototyyppivaiheessa incidentti = 'peli ei aukea/aja' → pysäytä, korjaa tai revert, kirjaa change reportiin." |

**Templatet:**

| Tiedosto | Verdikti |
|---|---|
| `CHANGE-REPORT.md` (54) | **(b) Säilytä yhtenä raporttiformaattina** — mutta huom. päällekkäisyys DoD:n kanssa (ks. kohta 3.2). Poista toinen kahdesta. |
| `INCIDENT-REPORT.md` (80) | **(c) Lykkää** yhdessä INCIDENT-MANAGEMENT.md:n kanssa. |
| `RELEASE-NOTES.md` (59) | **(c) Lykkää / kevyt stub** — mitään ei ole julkaistu. Halpa jättää, mutta ei kanoninen ennen ensimmäistä tagattua buildia. |
| `ADR-TEMPLATE.md` (57) | **Säilytä.** ADR-käytäntö on aidosti hyödyllinen ja halpa. |

**Lopputulos:** viisi governance-tiedostoa (900 riviä) + kolme aktiivista templatea → **yksi `GOVERNANCE-LIGHT.md` (~1 sivu)** + ADR-käytäntö + yksi raporttiformaatti + `deferred/`-kansio (incident + release, aktivoidaan Portti 3:ssa). Arvioitu lopputulos: **~250–300 riviä aktiivista governancea**, eli noin kolmasosa nykyisestä.

**Mitä light-tiedostoon jää (load-bearing, säilytä):**
1. R0–R5-riskiluokat (viitattu kaikkialla).
2. `Prototype vX.Y` + `0.x.y` versioformaatti (käytössä).
3. Yksi Claude Code -task- ja completion-report-formaatti.
4. Scope-suojaussääntö + "when to tighten governance" -laukaisin (Android-export / testaajat / raha → aktivoi lykätyt).
5. Evidence-first-validointisääntö (halpa, estää katteettoman "toimii").

---

## 3. Ohjaus/steering: päällekkäisyydet ja ristiriidat

### 3.1 "Do not build" -kieltolista on kuudessa paikassa — ja listat ajautuvat jo eri suuntiin

Sama poissulkulista toistuu, hieman eri sanoin joka kerta:

1. `CLAUDE.md` Hard rules
2. `build-plan.md` "Explicit non-goals before 7 Night MVP"
3. `BACKLOG.md` "Not before v0.6" + "Never without approval"
4. `mvp-scope.md` "Excluded from v0.1"
5. `CHANGE-CONTROL.md` "Scope creep rules"
6. `ADR-003` "Guardrails"

Tämä on **täsmälleen sama kaava** jonka CLAUDE.md-katselmointi paljasti. Pahempi kuin kosmeettinen toisto: listat **ovat jo eri sisältöisiä**. CLAUDE.md kieltää "complex crafting, multiplayer, story cutscenes, procedural generation" joita ei ole muualla; mvp-scope listaa "Radio, Escape vehicle" joita ei ole CLAUDE.md:ssä. Kuuden listan ylläpito käsin takaa ajautumisen.

**Suositus:** valitse **yksi kanoninen kieltolista**. Luontevin jako:
- **Ikuiset kiellot** (koko peli-identiteetti): `CLAUDE.md` Hard rules -lista. Muut viittaavat: "ks. CLAUDE.md Hard rules."
- **Raha-/julkaisukiellot ilman hyväksyntää:** `BACKLOG.md` "Never without approval". Kanoninen, muut viittaavat.
- **v0.1-vaihekohtainen poissulku:** `mvp-scope.md` "Excluded from v0.1". Tämä saa olla erillinen koska se on vaihekohtainen, ei ikuinen — mutta sen ei pidä toistaa ikuisia kieltoja, vaan viitata niihin.

CHANGE-CONTROL ja ADR-003 lakkaavat pitämästä omaa kopiotaan ja viittaavat.

### 3.2 Completion-report -formaatti on kahdessa paikassa

`DEFINITION-OF-DONE.md` sisältää "Claude Code completion report" -lohkon (Changed files / Validation / Not verified / …) JA `docs/templates/CHANGE-REPORT.md` on täydempi versio samasta artefaktista. Kaksi formaattia samalle raportille = toteuttaja arvaa kumpaa käyttää.

**Suositus:** yksi kanoninen. Säilytä `CHANGE-REPORT.md` templaattina, DoD viittaa siihen ("käytä CHANGE-REPORT.md") sen sijaan että toistaa oman lohkonsa.

### 3.3 Roadmap on kolmessa (osin neljässä) paikassa

Vaiheistus v0.1→v0.6 elää:
- `build-plan.md` (Phase 1–6 + tehtävälistat)
- `BACKLOG.md` (Now/Next/Later + kaupalliset tagit)
- `VERSIONING.md` "Prototype roadmap mapping" -taulukko
- `PRODUCTIZATION-ROADMAP.md` (kaupallinen painotaulukko)

`build-plan.md` on ~90 % päällekkäinen `BACKLOG.md`:n kanssa (samat vaiheet, tavoitteet, non-goalsit). Lisäksi build-plan Phase 1:n 11-kohtainen tehtävälista toistaa `docs/tasks/CLAUDE-CODE-TASKS-v0.1.md`:n ja prototype-v0.1-blueprintin sisältöä.

**Suositus:** valitse **BACKLOG.md kanoniseksi roadmapiksi** (siinä on jo kaupalliset tagit ja "Now/Next/Later"-rakenne). Joko poista `build-plan.md` tai kutista se vaihekohtaisiin validointikriteereihin (Phase X valmis kun…) jotka BACKLOG:sta puuttuvat, ja viittaa muuten BACKLOG:iin. VERSIONING:n mapping-taulukko sulautuu light-tiedoston versio-osioon. PRODUCTIZATION-ROADMAP säilyy (se on kaupallinen näkymä, ei sama asia).

### 3.4 Ei suoria ristiriitoja — mutta ajautumisriski on todellinen

En löytänyt yhtään kohtaa jossa kaksi dokumenttia sanoisi vastakkaista. Vaiheistus, versiointi ja portit ovat keskenään yhtenäisiä. Riski on **ajautuminen**: mitä useampi paikka toistaa saman asian käsin, sitä varmemmin ne eroavat seuraavan muutoksen jälkeen. Kohtien 3.1–3.3 konsolidointi poistaa tämän ennen kuin siitä tulee ristiriita.

---

## 4. Priorisoitu toimenpidelista (mikä ensin)

Järjestys = suurin ajautumisriski / halvin voitto ensin. Kaikki ovat R1 (docs-only) -muutoksia.

**P1 — Poista ajautumispommit (tee ensin, halvin ja tärkein):**
1. Konsolidoi "do not build" -kieltolista yhteen kanoniseen paikkaan per luokka (3.1). Muut viittaavat.
2. Yhdistä completion-report kahdesta formaatista yhteen (3.2): CHANGE-REPORT.md kanoninen, DoD viittaa.

**P2 — Poista roadmap-toisto:**
3. Nimeä BACKLOG.md kanoniseksi roadmapiksi. Poista tai kutista build-plan.md validointikriteereihin (3.3).

**P3 — Lykkää ennenaikainen governance:**
4. Siirrä INCIDENT-MANAGEMENT.md + INCIDENT-REPORT.md + RELEASE-NOTES.md → `docs/governance/deferred/`. Aktivoi Portti 3:ssa / Android-testauksessa. Jätä 2 riviä prototyyppi-incidentistä light-tiedostoon.

**P4 — Tiivistä loput yhteen light-tiedostoon:**
5. Sulauta GOVERNANCE.md + VERSIONING.md + CHANGE-CONTROL.md (R0–R5 + taskiformaatti) → yksi `GOVERNANCE-LIGHT.md` (~1 sivu). Poista DOCUMENTATION-STANDARD.md (tai kutista ~10 rivin nimeämissäännöksi light-tiedostoon).

**Säilytä sellaisenaan:** kaikki 3 ADR:ää + ADR-TEMPLATE, MVP-FAST-TRACK-PLAN, PRODUCTIZATION-ROADMAP, STRATEGY-ASSESSMENT, mvp-scope, prototype-v0.1/*, DEFINITION-OF-DONE (viittauskorjaus 3.2:n mukaan), CLAUDE.md.

**Miksi tässä järjestyksessä:** P1 poistaa aktiivisen ajautumisriskin (eri sanoin kirjoitetut kieltolistat, jotka jo eroavat) — se on halvin ja tärkein. P2–P3 poistavat ylläpitovelkaa. P4 on kosmeettisin (volyymin lasku) ja voi odottaa. Kaikki ovat docs-only-muutoksia, eivät koske pelikoodiin eivätkä uhkaa Portti 1:n kriittistä polkua (Task 003/005).

**Vaikutus:** ~1150 riviä governancea → ~250–300 riviä aktiivista. Kuusi kieltolistaa → kolme kanonista (per luokka). Kolme roadmap-kopiota → yksi kanoninen. Kuri säilyy, prosessiteatteri poistuu.
