# Until Morning — Game Systems

## 1. Päivä/yö-järjestelmä

Peli rakentuu päivä/yö-sykliin.

### Päivä

Päivällä pelaaja valmistautuu:

- valitsee retkikohteen
- kerää resursseja
- rakentaa
- korjaa
- käy kauppaa
- hoitaa tartuntaa
- valmistaa puolustuksia

### Yö

Yöllä zombit hyökkäävät:

- aallot kasvavat vaikeammiksi
- rakenteet ottavat vauriota
- pelaaja käyttää aseita ja ansoja
- base voi selvitä, vaurioitua tai kaatua

## 2. Retkijärjestelmä

Pelaaja ei kulje avoimessa maailmassa, vaan valitsee retkikohteita.

### Retkikohteella on

- riski
- loot-taulukko
- kesto
- säävaikutus
- zombie-riski
- mahdolliset NPC-tapahtumat

### Retken koukku

Mitä kauemmin pelaaja etsii, sitä parempaa lootia voi löytyä, mutta sitä enemmän riski kasvaa.

## 3. Reppujärjestelmä

Reppu rajoittaa mitä pelaaja saa tuotua takaisin.

### Peruslogiikka

- Jokainen item vie paikan tai painoa.
- Pelaaja joutuu valitsemaan mitä jättää.
- Reppua voi päivittää.

### Repputyypit

- pieni reppu: 6 paikkaa
- retkireppu: 9 paikkaa
- armeijareppu: 12 paikkaa
- kevyt reppu: 10 paikkaa, parempi liike
- runkoreppu: 15 paikkaa, hitaampi liike

## 4. Resurssit

### Perusresurssit

- ruoka
- vesi
- puu
- metalli
- ammukset
- lääkkeet
- osat
- polttoaine

### MVP-resurssit

- ruoka
- vesi
- puu
- metalli
- ammukset
- lääkkeet

## 5. Tartuntajärjestelmä

Tartunta erottaa pelin tavallisesta base defence -pelistä.

### Tartunnan tasot

- 0 %: terve
- 25 %: lievä heikennys
- 50 %: liike/tähtäys heikkenee
- 75 %: vakava tila, kulutus kasvaa
- 100 %: hahmon menetys / kuolema / kriisitilanne

### Lääkkeet

- hidastavat tartuntaa
- vähentävät tartuntaa
- pysäyttävät sen hetkeksi
- harvinainen lääke voi parantaa kokonaan

### Tärkeä sääntö

Tartunta ei saa tuntua maksuseinältä. Perushoito pitää olla saatavilla pelaamalla.

## 6. Ruoka ja vesi

Ruoka ja vesi luovat painetta, mutta eivät tapa heti.

### Ruoka loppuu

- liike hidastuu
- HP palautuu huonommin
- NPC:t tyytymättömiä
- retkien tuotto heikkenee

### Vesi loppuu

- stamina heikkenee
- tähtäys heikkenee
- tartunta/lämpöhaitat pahenevat
- helle on vaarallisempi

## 7. Base-rakentelu

Ei vapaata rakentelua. Rakennuspaikat ovat valmiita.

### Rakennukset

- puuaita
- vahvistettu aita
- portti
- piikkiansa
- ampumatorni
- valotorni
- miina
- vesitynnyri
- ruokavarasto
- työpöytä
- generaattori
- radio
- sairaalapöytä
- pakoauto

## 8. Yöpuolustus

Yö on 60–120 sekuntia.

Pelaaja voi:

- ampua zombeja
- aktivoida ansoja
- käyttää hätäkorjausta
- vaihtaa aseita
- käyttää medkitin
- suojata porttia

### Yön jälkeen

- vahinkoraportti
- resurssien kulutus
- palkinto
- seuraavan päivän valmistelu

## 9. Zombityypit

### MVP

- peruszombie
- juoksija
- tartuttaja

### Laajennus

- paksu zombie
- hajottaja
- kiljuja
- hiipijä
- jäätynyt zombie
- mutatoitunut zombie
- boss

## 10. NPC-järjestelmä

NPC:t ovat kevyitä mutta merkityksellisiä.

### NPC-roolit

- kauppias: vaihtokauppa
- hoitaja: tartunnan hallinta
- mekaanikko: pakoauto ja korjaukset
- partiolainen: paremmat retket
- vartija: yöpuolustus
- haavoittunut selviytyjä: valintatilanne
- lapsi: moraalinen pitkä kaari

## 11. Sääjärjestelmä

Sää muuttaa sääntöjä.

### Säätilat

- selkeä
- sade
- sumu
- myrsky
- pakkasyö
- helle
- saastunut sade
- pimeä yö

### Esimerkkejä

Sade:
- vesitynnyrit täyttyvät
- näkyvyys heikkenee
- tuliansat heikkenevät

Sumu:
- zombit näkyvät myöhään
- valotorni tärkeä
- ampumatornit reagoivat hitaammin

Saastunut sade:
- tartunta voi nousta ulkona
- sadevesi ei ole juotavaa ilman suodatinta
- tartuttajia enemmän

## 12. Radio ja sääennuste

Radio antaa tulevan sään 1–2 päivää etukäteen. Tämä tekee radiosta hyödyllisen myös ennen pakojuonta.

## 13. Pakokeino

Ensimmäinen suositus: panssaroitu auto.

Pakoauto antaa pitkäaikaisen tavoitteen ja pakottaa pelaajan retkille.
