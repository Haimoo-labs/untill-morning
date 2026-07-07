# Until Morning — GitHub Push Plan

## Ehdotettu branch

`docs/until-morning-design-pack`

## Ehdotettu sijainti repossa

Jos tämä on uusi peliprojekti nykyisen Haimoo-organisaation sisällä, järkevä sijainti olisi joko:

1. uusi erillinen repo, esimerkiksi `Haimoo-labs/until-morning`
2. nykyinen yleinen repo, esimerkiksi `Haimoo-labs/Haimoo`, jos sitä käytetään ideointi- ja konseptivarastona
3. erillinen `game-concepts`-repo, jos näitä peli-ideoita tulee useita

## Ehdotettu hakemistorakenne repossa

```text
/docs/game/until-morning/
  00-INDEX.md
  01-GAME-DESIGN-BRIEF.md
  02-ART-DIRECTION.md
  03-UI-UX-SPEC.md
  04-GAME-SYSTEMS.md
  05-MVP-SCOPE.md
  06-ECONOMY-MONETIZATION.md
  07-ASSET-LIST.md
  08-GITHUB-PUSH-PLAN.md

/assets/game/until-morning/concept/
  until-morning-design-pack-board.png
  until-morning-gameplay-reference.png
```

## Ehdotettu commit message

```text
docs: add Until Morning zombie survival design pack
```

## Commitin tarkoitus

Lisää zombie survival base defence -pelikonseptin ensimmäinen design pack:

- high concept
- core loop
- art direction
- UI/UX-spec
- gameplay systems
- MVP-rajaus
- monetization notes
- asset-lista
- visuaaliset referenssikuvat

## Ei sisälly commitissä

- ei Godot-projektia
- ei koodia
- ei SDK-integraatioita
- ei maksujärjestelmiä
- ei build-putkea
- ei salaisuuksia

## Review checklist

- [ ] Repo on oikea
- [ ] Branch on erillinen
- [ ] Kuvat ovat oikeassa assets-polussa
- [ ] Dokumentit ovat docs-polussa
- [ ] Ei tuotantokoodia
- [ ] Ei salaisuuksia
- [ ] Ei harhaanjohtavaa lupausta, että peli on jo toteutettu
- [ ] MVP-scope pysyy rajattuna

## Push-komennot manuaaliseen käyttöön

```bash
git checkout -b docs/until-morning-design-pack
mkdir -p docs/game/until-morning assets/game/until-morning/concept
cp -R <package>/docs/game/*.md docs/game/until-morning/
cp <package>/assets/concept/until-morning-design-pack-board.png assets/game/until-morning/concept/
cp <package>/assets/reference/until-morning-gameplay-reference.png assets/game/until-morning/concept/
git add docs/game/until-morning assets/game/until-morning/concept
git commit -m "docs: add Until Morning zombie survival design pack"
git push -u origin docs/until-morning-design-pack
```
