# AGENTS.md — Zkouškomat ZZ-01

Tento soubor je závazný pracovní kontext pro AI asistenty a vývojáře.

## 1. Nezačínej od nuly

Projekt je dlouhodobě rozpracovaný. Neprováděj plošný rewrite jen proto, že by byl technicky pohodlnější. Nejprve zkontroluj existující funkce a zachovej vše, co funguje.

Aktuální logický základ je `index.html` / `prototype/logic_v23_sborovna.html`.

## 2. Pořadí autority

Při rozporu platí:

1. `docs/spec_v34.txt`
2. `docs/visual_reference.txt`
3. `docs/visual_brief.txt`
4. `docs/summary_v32.txt`
5. funkční prototypy
6. starší obrazové reference

Nikdy si nevymýšlej novou funkci nebo nový vizuální směr, pokud je již rozhodnutý v těchto zdrojích.

## 3. Funkční principy

- Zkouškomat je pomůcka pro učitele, ne automatický disciplinární systém.
- Systém může doporučit kandidáty, konečné rozhodnutí vždy dělá učitel.
- Známka vychází z prokázaných znalostí, ne z trestných bodů.
- Trestné body ovlivňují výběr ke zkoušení podle definovaných režimů.
- Každý žák má vlastní nezávislý stav.
- Třídy a seznamy žáků mohou být školní data; provozní data musí respektovat vazbu učitel + třída + předmět.
- Data různých škol se nesmí promíchat.
- Globální navigace musí obsahovat bezpečný krok „Zpět“ a návrat nesmí zbytečně zahazovat rozpracovaný stav.
- Pokud probíhá zkoušení, navigace nesmí bez varování zrušit časovač nebo výsledek.

## 4. Pravidla a zkoušení

Výchozí editovatelná pravidla zahrnují například:

- Sedí v poslední řadě
- Nemá pomůcky
- Nemá přezůvky
- Svačí bez domluvy
- Mobil bez dovolení
- Pozdní příchod
- Často neodevzdává práci v termínu

Přesné chování, body, ochranné intervaly, losování a systémové pravidlo ověř v `docs/spec_v34.txt`. Názvy běžných pravidel nesmí být natvrdo zakódované jako neměnné, pokud specifikace říká, že jsou editovatelné.

## 5. Vizuální kontrakt

Závazný styl:

- retro arkáda / pixel-art / CRT panel,
- tmavě modrá až černá,
- cyan / tyrkysová,
- oranžové hlavní akce,
- krémově bílý text,
- pixelový charakter,
- jemné scanlines,
- hranaté panely a tlačítka,
- hravé, ale ne dětské.

Nedělej generické moderní neonové UI. Nepoužívej vizuální reference jako screenshot na pozadí. Rozhraní musí být skutečné, responzivní a interaktivní.

Při konfliktu staršího a novějšího vzhledu platí `docs/visual_reference.txt` a novější pojmenované reference.

## 6. Responzivita

- Jedna společná aplikace pro desktop i mobil.
- Seznamy žáků se při větším počtu scrollují.
- Výběr tříd je rozbalovací výběrový prvek.
- Ovládací prvky musí být použitelné dotykem.
- Pixelový styl nesmí zhoršit čitelnost delších textů.

## 7. Data a soukromí

Nikdy necommituj skutečná školní data, jména žáků, známky, e-maily uživatelů, tokeny, hesla nebo tajné klíče.

Používej pouze testovací/demonstrativní data. Produkční data musí být uložena mimo zdrojový kód a přístup musí respektovat role a školní izolaci.

## 8. Změny

Při každé větší změně:

1. urč, jaké rozhodnutí ze specifikace implementuješ,
2. zachovej existující funkční části,
3. změň co nejmenší nutný rozsah,
4. otestuj návazné workflow,
5. zapiš významnou změnu do `CHANGELOG.md`.

Pokud je zadání nejasné, preferuj zachování dat a existujícího chování před destruktivní změnou.
