# ZZ-01_POINT_EXPLANATION_CONFIRM — vysvětlení účinku bodů + potvrzení

- při definování nebo úpravě pravidla se pod polem Body živě zobrazuje slovní vysvětlení účinku zadané hodnoty
- záporná hodnota zobrazuje červeně „Přiděluješ trestné body“
- kladná hodnota zobrazuje zeleně „Odebíráš trestné body“ a vysvětluje, že případný přebytek se započítá jako pochvalné body
- nulová hodnota se zobrazuje neutrálně jako „Bez bodové změny“
- před uložením nového nebo upraveného pravidla se zobrazí potvrzovací okno s názvem pravidla, hodnotou a slovním významem
- tlačítko „Zpět“ vrací uživatele do editoru se zachovanými rozepsanými hodnotami
- při běžném zaškrtávání podmínek během zahájení zkoušení se žádné potvrzení nepřidává
- stejná živá vysvětlivka je přidána do formuláře Šéfové pro ruční udělení bodů
- Šéfová před skutečným odesláním dostane potvrzení „Potvrdit výtku?“ nebo „Potvrdit pochvalu?“
- potvrzení Šéfové zobrazuje učitele, důvod, znaménko bodů a slovní účinek
- po volbě „Zpět“ se formulář Šéfové obnoví se zachovaným učitelem, důvodem i počtem bodů
- požadavek na povinný důvod u Šéfové zůstává zachován
- samotná logika znamének z předchozího patche se nemění: − je trest, + je pochvala / vyrovnání trestu

--- Původní changelog zachovaný v plném rozsahu ---

# ZZ-01_SIGNED_POINTS_LOGIC — sjednocení znamének bodů

- celá aplikace nově používá jednotnou logiku: záporné body (−) jsou trestné, kladné body (+) jsou pochvalné / odměnové
- výchozí trestná pravidla žáků byla převedena z kladných hodnot na záporné hodnoty
- editor pravidel nyní dovoluje hodnoty −99 až +99 a přímo vysvětluje význam znamének
- kladné a záporné hodnoty pravidel se v aplikaci zobrazují se správným znaménkem; záporné jsou červené a kladné zelené
- aktuální bodová bilance žáka je podepsaná: např. −3 je trestná bilance, +2 pochvalná bilance
- vážený los používá pouze velikost záporné části bilance; −3 znamená 3 trestné body pro váhu losu, kladná bilance trest nezvyšuje
- dlouhodobé „nasbírané“ body žáků se nově vedou ve stejné podepsané logice
- stará lokální data se při prvním načtení automaticky migrují: dosavadní kladné trestné hodnoty pravidel a žáků se převedou na záporné
- staré efekty vlastních skříněk se při migraci také obrátí; vestavěná odměna „Mínus jeden bod“ je nově „Pochvala +1“
- vlastní skříňky používají stejnou logiku: − trest, + pochvala
- u Šéfové zůstává scoring matematicky podepsaný: záporné body snižují skóre, kladné body předchozí záporné body vyrovnávají a případně tvoří bonus
- rozhraní Šéfové výslovně uvádí „− = trestné body, + = pochvalné body“
- upozornění „Pochvala od Šéfové“ / „Výtka od Šéfové“ zůstává zachováno a odpovídá znaménku
- bodové záznamy Šéfové se nemigrují, protože již před tímto patchem měly správnou logiku: + bylo kladné a − záporné
- hlavní menu, sdílené třídy, testovací účty, avatary a animace zkoušení zůstávají zachované

--- Původní changelog zachovaný v plném rozsahu ---

# ZZ-01_BOSS_FEEDBACK_NOTIFICATIONS — pochvala a výtka od Šéfové

- při novém ručním bodovém zásahu Šéfové se cílovému učiteli uloží jednorázové upozornění
- kladné body zobrazí zavíratelné okno „Pochvala od Šéfové“
- záporné body zobrazí zavíratelné okno „Výtka od Šéfové“
- v okně je uvedeno jméno Šéfové, povinný důvod a výrazný počet přidaných nebo odebraných bodů
- kladné body jsou vykreslené zeleně, záporné body červeně
- upozornění lze zavřít křížkem nebo tlačítkem „Zavřít“
- po zavření se zpráva označí jako přečtená a už znovu nevyskočí
- pokud čeká více zpráv od Šéfové, zobrazí se postupně po jedné
- starší historické bodové záznamy před tímto patchem žádné nové vyskakovací zprávy nevytvoří
- během právě běžícího časovaného zkoušení upozornění nevyskakuje
- tlačítko „Přidělit body“ je u Šéfové neaktivní, dokud není vybraný učitel a vyplněný důvod
- původní serverová validace důvodu zůstává zachovaná jako druhá kontrola
- ostatní scoring, testovací účty, sdílené třídy, avatary, hlavní menu i animace zkoušení zůstávají beze změny

--- Původní changelog zachovaný v plném rozsahu ---

# ZZ-01_MAIN_MENU_BITMAP_FONT_V1 — písmo hlavního menu podle reference

- texty v tlačítkách hlavního menu už nepoužívají systémový `Fixedsys` ani jiný náhradní font
- přidán vlastní 5×7 bitmapový renderer přímo v aplikaci, takže vzhled je stejný na každém počítači
- styl se drží reference „Moje předměty“: smíšená velikost písmen, hrubé čtvercové pixely, minimální mezery a žádné vyhlazování
- zachována česká diakritika v názvech menu (`á`, `í`, `ř`, `š`, `ě` atd.)
- odstraněna předchozí žlutá uppercase varianta hlavního menu
- změna se týká pouze názvů osmi dlaždic hlavního menu; ostatní typografie aplikace zůstává beze změny
- zachovány opravy Body učitelů a Scoringu, testovací účty, sdílené třídy, avatary i animace zkoušení

--- Původní changelog zachovaný v plném rozsahu ---

# ZZ-01_BOSS_POINTS_AND_SCORING_FIX — Body učitelů + Scoring

- nalezena společná příčina obou chyb po prvním přidělení bodů Šéfovou
- historie bodů používala neexistující funkci `formatDate(...)`
- oba chybné výskyty byly nahrazeny existující funkcí `fmtDate(...)`, kterou aplikace používá i v ostatních přehledech
- po prvním bodovém zásahu lze znovu otevřít „Body učitelů“
- tlačítko „Scoring / Přehledy“ z hlavního menu po bodovém zásahu opět vykreslí Scoring
- zachována předchozí oprava bezpečného opakovaného otevření modálu Body učitelů
- testovací účty, sdílené třídy, avatary a animace zkoušení zůstávají beze změny

--- Původní changelog zachovaný v plném rozsahu ---

# ZZ-01_BOSS_POINTS_REOPEN_FIX — opakované otevírání Body učitelů

- opraveno opakované otevírání okna „Body učitelů“ u Šéfové
- po tlačítku „Hotovo“ se aktuální obrazovka znovu vykreslí, takže tlačítko „Body učitelů“ má vždy čerstvou obsluhu
- po přidělení bodů se obnovení modálního okna provádí až v dalším event loopu, ne uvnitř právě běžícího click handleru
- stejný bezpečný způsob obnovení je použit i po stornu nebo zrušení storna
- bodové záznamy, historie, limity a role Šéfové zůstávají beze změny
- testovací účty, sdílené třídy, avatary i animace zkoušení zůstávají zachované

--- Původní changelog zachovaný v plném rozsahu ---

# ZZ-01_TEST_USERS_A1 — testovací víceuživatelský režim

- přidány dva lokální testovací účty: „Testovací učitel“ a „Testovací Šéfová“
- v Nastavení je nová karta „Testovací režim“ pro okamžité přepnutí mezi administrátorem, běžným učitelem a Šéfovou
- přepnutí používá stejná lokální školní data, takže lze bez druhého účtu otestovat sdílené třídy
- Testovací učitel začíná bez přiřazených tříd a může si existující školní třídu přidat přes „Třídy školy“
- Testovací Šéfová má běžná práva učitele a při aktivním přepnutí skutečnou roli Šéfová, včetně nástroje „Body učitelů“
- původní Šéfová školy se při přepnutí na Testovací Šéfovou dočasně uloží a po přepnutí zpět automaticky obnoví
- horní lišta nyní u aktivní Šéfové správně zobrazuje roli „šéfová“
- testovací účty se automaticky doplní i do již existujících lokálních uložených dat
- sdílené třídy, avatary a animace zkoušení zůstávají zachované
- testovací režim je určen pouze pro lokální prototyp; nenahrazuje budoucí skutečné přihlášení více uživatelů přes databázi

--- Původní changelog zachovaný v plném rozsahu ---

# ZZ-01_SCHOOL_CLASSES_A1 — sdílené třídy školy

- třída je nově školní objekt: název, školní rok a seznam žáků jsou společné pro učitele stejné školy
- každá třída eviduje, kteří učitelé ji používají (`teacherIds`) a kdo ji založil (`createdByTeacherId`)
- každý učitel má u stejné třídy vlastní přiřazené předměty (`teacherSubjects`)
- témata předmětů jsou navázaná na konkrétního učitele (`questionSets.teacherId`)
- obrazovka „Moje třídy“ ukazuje jen třídy používané aktuálním učitelem
- přidáno tlačítko „Třídy školy“ s přehledem společných tříd a volbou „Přidat k mým třídám“
- přidání existující třídy nekopíruje žáky ani třídu; učitel používá stejnou školní třídu
- zkoušení, známkování, scoring „moje třídy“ a nabídka předmětů respektují pouze třídy a předměty aktuálního učitele
- úprava názvu třídy, školního roku a žáků je společná pro školu; úprava předmětů zůstává osobní pro učitele
- stará uložená data se při načtení automaticky převedou do nového modelu
- avatarový patch A1 i animace zkoušení zůstávají zachované
- současná offline HTML verze stále ukládá data lokálně; skutečné sdílení mezi různými zařízeními bude po napojení na společný server/databázi

--- Původní changelog zachovaný v plném rozsahu ---

# ZZ-01_AVATAR_PACK_A1 — 20 retro avatarů učitelů

- přidáno 20 nových obrázkových avatarů učitelů: 10 žen a 10 mužů
- avatary mají záměrně jednoduchý starší 8bitový vzhled a nízké logické rozlišení
- nové assety jsou uloženy v `assets/avatars/`
- výběr avataru v Nastavení je nově schovaný v otevíracím panelu „Vybrat avatar“
- uvnitř jsou oddělené skupiny „Ženy“ a „Muži“
- avatar se po výběru dál používá ve stejných místech aplikace jako dříve
- původní `px:*` avatary zůstaly interně zachované pouze kvůli kompatibilitě se staršími uloženými profily
- vlastní nahrání obrázku zůstává zachováno
- animace zkoušení a ostatní logika aplikace zůstaly beze změny

--- Původní changelog zachovaný v plném rozsahu ---

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
