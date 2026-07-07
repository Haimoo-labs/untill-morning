# Until Morning — MVP Scope

## MVP:n tavoite

Todistaa, että päivä/yö survival defence -looppi on hauska ja koukuttava Androidissa.

MVP:n ei tarvitse sisältää koko peliä. Sen pitää todistaa tämä:

> Päivällä tehtävät päätökset vaikuttavat suoraan siihen, selviääkö pelaaja yöllä.

## MVP:n sisältö

### Base

- yksi tukikohta
- yksi keskeinen rakennus/teltta
- aita/portti
- nuotio
- rakennuspaikat
- yövaiheen puolustusalue

### Retkikohteet

3 kohdetta:

1. Metsä
   - matala riski
   - puu, ruoka, vähän vettä

2. Rautakauppa
   - keskitaso
   - puu, metalli, osat

3. Apteekki
   - korkea riski
   - lääkkeet, sidetarpeet

### Resurssit

MVP:ssä riittää:

- ruoka
- vesi
- puu
- metalli
- ammukset
- lääkkeet

### Rakennukset

3 rakennusta:

- puuaita
- piikkiansa
- ampumatorni

### Pelaajan tila

- HP
- tartunta %
- ruoka/jano yksinkertaisena paineena

### Reppu

- 6 paikkaa
- pelaaja valitsee mitä ottaa mukaan
- yksi mahdollinen päivitys 6 → 9 paikkaan

### Zombit

3 zombie-tyyppiä:

- peruszombie
- juoksija
- tartuttaja

### Sää

3 säätilaa:

- selkeä
- sade
- sumu

### NPC:t

2 NPC:tä:

- kauppias
- hoitaja

### Tavoite

MVP-tavoite:

- selviä 10 päivää
- rakenna radio

## Mitä EI tehdä MVP:hen

- ei avointa maailmaa
- ei vapaata rakentelua
- ei suurta crafting-puuta
- ei pakoautoa vielä, vain radiotavoite
- ei season passia
- ei oikeaa IAP/token-kauppaa
- ei mainoksia
- ei useita baseja
- ei kymmeniä NPC:tä
- ei boss-zombeja ensimmäisessä versiossa, ellei looppi toimi jo hyvin

## MVP:n onnistumiskriteerit

MVP toimii, jos pelaajalle syntyy seuraava tunne:

- “Minulla ei ole tarpeeksi aikaa tehdä kaikkea.”
- “Yö tulee liian nopeasti.”
- “Minun olisi pitänyt korjata aita.”
- “Vielä yksi päivä.”

## Ensimmäinen testattava pelikierros

1. Päivä alkaa.
2. Pelaaja näkee resurssit ja tehtävät.
3. Pelaaja valitsee retkikohteen.
4. Pelaaja kerää lootia ja täyttää repun.
5. Pelaaja palaa baseen.
6. Pelaaja rakentaa tai korjaa.
7. Yö alkaa.
8. Zombit hyökkäävät.
9. Pelaaja selviää tai häviää.
10. Aamuraportti kertoo seuraukset.

## Ensimmäisen version scope-lause

Yksi base, kolme retkikohdetta, kolme zombityyppiä, kolme säätilaa ja yksi selkeä 10 päivän selviytymistavoite.
