# Zkouškomat ZZ-01

**Zkouškomat** je webová aplikace pro učitele určená jako hravý doplněk k ústnímu zkoušení. Interní označení projektu je **ZZ-01**.

> Slogan projektu: „Proč zkoušet jednoduše, když to jde složitě.“

## Stav tohoto repozitáře

Toto je konsolidovaný vývojový balík projektu. Obsahuje:

- aktuální funkční prototyp logiky (`index.html`),
- úplnou aktuální specifikaci (`docs/spec_v34.txt`),
- samostatné vizuální zadání a vizuální kontrakt,
- předchozí funkční a designové prototypy,
- schválené vizuální reference,
- sadu ikon aplikace.

`index.html` je v této fázi především **funkční základ**. Finální vzhled se má implementovat podle `docs/visual_reference.txt`, `docs/visual_brief.txt` a obrázků v `assets/references/`. Referenční obrázky se nemají vkládat jako screenshotové pozadí aplikace; výsledné rozhraní musí být skutečné, responzivní a interaktivní HTML/CSS/JS.

## Zdroj pravdy – pořadí priority

Při rozporu mezi soubory platí toto pořadí:

1. `docs/spec_v34.txt` – hlavní aktuální funkční specifikace projektu.
2. `docs/visual_reference.txt` – závazný vizuální kontrakt a význam referencí.
3. `docs/visual_brief.txt` – podrobnější zadání vizuálního zpracování.
4. `docs/summary_v32.txt` – stručnější projektový souhrn.
5. `prototype/logic_v23_sborovna.html` – poslední konsolidovaný funkční prototyp, ze kterého vychází `index.html`.
6. `prototype/arcade_design.html` a `prototype/preparation_reference.html` – vizuální/prototypové podklady.
7. Starší nebo obrazové návrhy – pouze jako reference, pokud nejsou v rozporu s novější specifikací.

## Základní principy aplikace

- Aplikace **doporučuje kandidáty**, ale konečné rozhodnutí vždy dělá učitel.
- Pracuje s přítomností, editovatelnými pravidly a trestnými body, ochranou proti příliš častému zkoušení a historií.
- Workflow počítá s výběrem třídy a předmětu, přítomností, pravidly, kandidáty, tématem/otázkou, samotným zkoušením, známkou a zápisem výsledku.
- Obsahuje rozšiřující moduly jako Kolo štěstí, školní skříňka, propustka, scoring, učitelský scoring, trofeje, achievementy a školní výzvy.
- Má fungovat na počítači i telefonu z jednoho společného základu.
- Uživatelské rozhraní je česky.

## Vizuální směr

Závazný charakter:

- retro arkáda / 8–16bit / CRT ovládací panel,
- tmavě námořnické až téměř černé pozadí,
- cyan / tyrkysové rámečky a sekundární prvky,
- oranžová pro hlavní akce a potvrzení,
- světlý krémový text,
- pixelový charakter bez zhoršení čitelnosti,
- hranaté ovladače, jemné scanlines,
- hravé a lehce recesistické, ale **ne dětské**.

Viz `assets/VISUAL_MANIFEST.md`.

## Ochrana dat

Do repozitáře **necommitovat skutečná jména žáků, známky, školní záznamy, přístupové tokeny, hesla ani jiné provozní osobní údaje**. Repozitář má obsahovat pouze zdrojový kód, testovací data a designové podklady. Skutečná data mají být řešena oddělenou datovou vrstvou / lokálním úložištěm podle fáze vývoje.

Doporučení: repozitář držet jako **Private**, dokud není vyřešená produkční architektura a ochrana dat.

## Struktura

```text
ZZ-01/
├─ index.html                         # aktuální funkční základ
├─ AGENTS.md                          # pokyny pro AI / další vývoj
├─ README.md
├─ CHANGELOG.md
├─ .gitignore
├─ docs/
│  ├─ spec_v34.txt                    # hlavní specifikace
│  ├─ visual_reference.txt            # vizuální kontrakt
│  ├─ visual_brief.txt
│  ├─ summary_v32.txt
│  ├─ trophies_spec_v1.txt
│  └─ PRIVACY.md
├─ prototype/
│  ├─ logic_v23_sborovna.html
│  ├─ arcade_design.html
│  └─ preparation_reference.html
└─ assets/
   ├─ VISUAL_MANIFEST.md
   ├─ icons/
   └─ references/
```

## Jak pokračovat ve vývoji

1. Nezačínat aplikaci znovu od nuly.
2. Nejdřív ověřit, co už funguje v `index.html`.
3. Funkční logiku měnit po menších krocích a po každém kroku testovat.
4. Vizuál implementovat skutečnými komponentami podle vizuálního kontraktu; nepoužívat screenshoty jako UI.
5. Zachovat data a stav při navigaci a návratu zpět.
6. Před nasazením doplnit bezpečnou autentizaci, databázi, role a izolaci školních dat.
7. Otestovat desktop, iPhone a Android.

Podrobnosti jsou v `AGENTS.md` a zejména v `docs/spec_v34.txt`.
