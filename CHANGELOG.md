# ZZ-01_EXAM_SCENE_F2 — integrace do index(5).html

- Základ: index(5).html a CHANGELOG(5).md dodané uživatelem v tomto chatu.
- Zachován slogan v hlavičce, písmo hlavního menu, filtrování předmětů podle třídy a Trofeje.
- Přidaných 16 schválených scén zkoušení; přepínání podle zbývajícího času.
- Pauza drží poslední scénu; přednačtení a zachování obrazu při chybě dalšího obrázku.
- Countdown, hudba, hodnocení, data a ostatní logika beze změn.
- Velká časomíra zachována, malé horní překryvy a třesení učebny odstraněny.
- Přesčas je pouze vizuální scénka; sám neukončuje zkoušení ani nezapisuje známku.

Ověření: syntaxe, přechody scén, pauza, nový pokus, chyba obrázku, integrita PNG,
a přesná shoda celého kódu mimo vymezenou změnu s index(5).html.
Přímý běh v prohlížeči zde nebylo možné ověřit. Jde o klíčové snímky, nikoli plynulou
sprite animaci; drobné rozdíly v kresbě postav a rekvizit mezi snímky zůstávají.

--- Původní changelog zachovaný v plném rozsahu ---

# ZZ-01_HEADER_SLOGAN_UPDATE

- v horní hlavičce nahrazen text `ZZ-01` sloganem „Proč zkoušet jednoduše, když to lze složitě.“
- odstraněn duplicitní slogan „Proč zkoušet jednoduše, když to lze složitě?“ pod obrázkem Hlavní menu
- slogan na úvodní/loading obrazovce zůstává zachován
- ostatní funkce a rozložení aplikace zůstávají beze změny

## PATCH — písmo hlavního menu

- upraveny pouze textové popisky dlaždic hlavního menu
- nahrazen velmi tučný vzhled (`font-weight: 900`) jemnějším `font-weight: 600`
- nové bezpatkové arkádové písmo: Bahnschrift / Trebuchet MS / Segoe UI / Arial
- barva běžných položek změněna na tlumenou slunečnicově žlutou
- odstraněn výrazný světlý dojem; doplněna pouze jemná tmavá kontura pro čitelnost
- hlavní oranžová akce používá mírně tmavší odstín stejného barevného směru
- rozměry, ikony, rozmístění a funkce hlavního menu zůstávají beze změny
- texty v dlaždicích hlavního menu nově zobrazeny VELKÝMI PÍSMENY
- typografie hlavního menu dále upravena do hranatějšího bitmapového arcade stylu (Fixedsys/Terminal), s mírně vyšší vahou a hrubší pixelovou kresbou bez měkkého světelného efektu

## PATCH — filtrování předmětů podle třídy

- v obrazovce Zahájení zkoušky se po výběru třídy zobrazují pouze předměty přiřazené této konkrétní třídě
- předměty z ostatních tříd se už do nabídky nemíchají
- při změně třídy se dříve vybraný předmět nadále správně vynuluje
- ostatní průchod zkoušením zůstává beze změny

## PATCH — sjednocení terminologie na Trofeje

- v celé uživatelské části aplikace se nepoužívá označení Achievementy / achievement
- ve scoringu je sekce přejmenována z „Achievementy“ na „Trofeje“
- texty „Tajný achievement“ a „Skrytý achievement“ jsou změněny na „Tajná trofej“ a „Skrytá trofej“
- popis rarity nově používá formulaci „Nejvzácnější veřejné trofeje“
- interní technické názvy funkcí, CSS tříd a datových klíčů zůstávají beze změny kvůli kompatibilitě
