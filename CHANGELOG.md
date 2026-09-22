# ZZ-01 — Compact Exam Flow A

## Cíl
Zrychlit zahájení zkoušení během reálné vyučovací hodiny a snížit počet obrazovek, kliknutí a vnitřního scrollování.

## Změny
- kompaktnější obrazovka „Zahájit zkoušení“
- třída a předmět jsou vedle sebe na desktopu, na mobilu pod sebou
- odstraněna velká souhrnná karta a nadbytečný vizuální prostor
- sloučena Přítomnost + Pravidla do jedné obrazovky
- všichni žáci jsou v jedné tabulce pod sebou; tabulka se zvětšuje s obsahem stránky
- odstraněn vnitřní scroll seznamu žáků
- každý řádek obsahuje: žáka, přítomnost, body a tlačítko „Pravidla“
- pravidla se rozbalují pouze pod konkrétním žákem
- nepřítomný žák má pravidla deaktivovaná a nejde do losování
- přepnutí přítomnosti nepřekresluje celou stránku ani neskáče na začátek
- při změně pravidel se zachová pozice na stránce
- samostatný krok „Pravidla a trestné body“ je v běžném průchodu přeskočen
- příprava zkoušení má nově 5 kroků místo 6

## Nový průchod
1. Třída + předmět
2. Žáci + přítomnost + pravidla
3. Kandidáti
4. Téma
5. Zkoušení


## Hotfix A1 – Předmět na kroku 1
- opraven vzhled tlačítek pro výběr předmětu na obrazovce „Zahájit zkoušení“
- názvy předmětů už nejsou černé, ale ve světlém arkádovém stylu
- text je nově centrovanější a nevejde-li se, zkrátí se korektně uvnitř tlačítka
- rozložení předmětů je přehlednější: 2 sloupce na desktopu, 1 sloupec na mobilu
- tlačítka mají větší vnitřní prostor a lépe sedí s checkboxem


## Hotfix A2 – profesionální arcade výběr předmětu
- úplně přepracovaný výběr předmětu na obrazovce Zahájit zkoušení
- jeden přehledný sloupec místo natlačené mřížky
- celý řádek je velká klikací plocha
- dlouhé názvy se správně zalamují a nikdy neleží přes okraj tlačítka
- arkádový pixelový font a světlý text ve všech stavech
- vybraný předmět používá oranžový accent, ale zůstává dobře čitelný
- jasnější indikátor výběru a lepší hover/focus stav


# PRO ARCADE UI PACK – GLOBAL NON-HOME THEME

- sjednocuje vizuální jazyk všech pracovních obrazovek podle schváleného profesionálního výběru předmětu
- hlavní menu zůstává záměrně beze změny
- sjednocené tmavé panely, cyanové linky a oranžové selected/primary stavy
- kompaktnější nadpisy a menší vertikální plýtvání místem
- jednotná tlačítka, formuláře, záložky, tabulky, badge a modalní okna
- tabulky už nemají vlastní vertikální scroll limit; stránka roste s obsahem
- speciální herní vizuály (kolo, učebna během zkoušení, trofeje) se nepřekreslují
- funkční logika aplikace nebyla změněna

## Pro Arcade UI V2 — chamfered frames + lighter headings
- hlavní menu zůstává beze změny
- sjednocen tvar hlavních karet a panelů podle obrazovky „Moje třídy“
- globálně přidány sražené rohy na karty, panely, tabulkové kontejnery, výběrové řádky, tlačítka a dialogy mimo hlavní menu
- generické panely dostaly jemný dvojitý cyanový rám a pixelový stín
- všechny hlavní nadpisy mimo hlavní menu používají lehčí technický bezpatkový font (Bahnschrift / Segoe UI fallback)
- nadpisy už nejsou přehnaně tučné; váhy jsou zhruba 500–600
- zůstává lehký retro/arcade charakter díky drobnému spacingu a stínu
- funkce a obsah obrazovek se nemění
