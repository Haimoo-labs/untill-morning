# Until Morning — UI / UX Spec

## Tavoite

UI:n pitää tukea Android-first-pelaamista. Pelaajan pitää ymmärtää nopeasti:

- mikä päivä/yö on menossa
- paljonko aikaa on jäljellä
- mitkä resurssit ovat kriittisiä
- mitä tehtäviä on auki
- mitä voi rakentaa
- mitä basessa on rikki
- mistä zombit tulevat
- mitä pelaajan kannattaa tehdä seuraavaksi

## UI:n pääperiaate

Näytä vain kulloinkin tärkeä tieto. Päivä-, retki- ja yötilat voivat käyttää eri UI-asettelua.

## Yläpalkki

Näytetään aina:

- päivä / yö
- kellonaika tai jäljellä oleva aika
- resurssit
- premium-tokenit
- asetukset

### Päivällä

- päivä X
- kellonaika
- puu
- metalli
- ruoka
- vesi
- ammukset
- tokenit

### Yöllä

- yö X
- aika jäljellä
- aalto
- zombit jäljellä
- base HP
- ammukset / aseet

## Vasen paneeli päivällä

### Tehtävät

Näyttää 2–4 selkeää tehtävää:

- kerää puuta
- kerää ruokaa
- täytä vesitynnyri
- rakenna piikkiansa
- korjaa portti

### Retkikohteet

Retkikohteen kortti näyttää:

- nimi
- riskitaso
- tärkein loot
- mahdollinen säävaikutus

Esimerkki:

**Rautakauppa**
Riski: keskitaso
Mahdollinen loot: puu, metalli, työkalut

## Oikea paneeli päivällä

Rakennusvalikko näyttää vain valitun kategorian.

Esimerkiksi `Rakenna`:

- puuaita
- piikkiansa
- valotorni
- ampumatorni
- miina

Jokaisessa rivissä:

- pieni ikonikuva
- nimi
- kustannus
- tila: ostettavissa / puuttuu resursseja / lukittu

## Alapalkki päivällä

Päätoiminnot:

- Rakenteet
- Varasto
- Korjaa
- Kauppa
- Retki / Lähde etsimään

Painikkeiden pitää olla isoja ja peukalolla osuttavia.

## Retkivalinta

Retkikohteet eivät saa olla liian pieniä. Korttirakenne:

- iso ikonikuva
- kohteen nimi
- riskitaso
- loot-ikonit
- retken kesto
- lähde-painike

Riskin visuaalinen asteikko:

- vihreä = turvallinen
- keltainen = keskitaso
- punainen = korkea
- violetti/musta = erittäin korkea / tartuntariski

## Retkinäkymä

Retkinäkymän ydintieto:

- reppu: montako paikkaa käytössä
- aika jäljellä
- melutaso / vaarataso
- löydetyt itemit
- poistu-painike

Retken päätöshetki syntyy, kun reppu täyttyy ja pelaajan pitää valita mitä ottaa mukaan.

## Yöpuolustus-UI

Yöllä UI pitää muuttua toimintapainotteiseksi.

Näytetään:

- yö X
- aalto X/Y
- zombit jäljellä
- base HP
- valittu ase
- ammukset
- medkit
- kranaatti / ansa / miina
- hätäkorjaus
- pause

### Alapalkki yöllä

- ansa
- aita / hätäeste
- ampumatorni
- miina
- hätäkorjaus

### Oikea asevalikko

- pääase
- sivuase
- medkit
- heitettävä esine

## Aamuraportti

Aamuraportin pitää olla palkitseva mutta nopea.

Näytetään:

- päivä selvitty
- tapetut zombit
- rakennusvauriot
- kulutetut resurssit
- saadut palkinnot
- NPC-tapahtuma
- seuraava sää, jos radio käytössä
- jatka-painike

## Ilmoitukset

Ilmoitusten pitää olla lyhyitä.

Hyviä ilmoituksia:

- Portti vaurioitui
- Vesi loppumassa
- Tartunta pahenee
- Sumu nousee illaksi
- Kauppias saapui
- Ase jumissa
- Hätäkorjaus käytetty

## Mobiiliohjauksen periaate

- Napauta kohdetta valitaksesi
- Napauta rakennuspaikkaa rakentaaksesi
- Pidä pohjassa nähdäksesi lisätietoa
- Yöllä tähtäys voi olla napautus/drag riippuen taistelumallista
- Tärkeimmät painikkeet alas ja sivuihin, ei keskelle tapahtumien päälle

## UI-riskit

Suurin riski on, että ruudulle tulee liikaa tietoa. Ensimmäiseen versioon pitää rajata:

- max 5–6 resurssia näkyvissä
- max 3–4 tehtävää kerralla
- max 5 rakennusvaihtoehtoa yhdessä paneelissa
- max 4 käyttöesinettä yöllä
