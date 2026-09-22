# Changelog

## 2026-09-21 — GitHub baseline

- Konsolidován aktuální funkční prototyp jako `index.html`.
- Přidána hlavní specifikace v34.
- Přidány vizuální podklady, vizuální kontrakt a aplikační ikony.
- Zachovány prototypy logiky i vizuálního návrhu pro porovnání.
- Přidán `AGENTS.md` pro bezpečné pokračování vývoje bez přepisování existující logiky.
- Přidána pravidla ochrany dat a `.gitignore`.

## 2026-09-21 — Visual pass v1
- Hlavní menu převedeno do schváleného retro/pixelového vzhledu podle vizuální reference.
- Přidány výřezy schválených menu ikon jako samostatné UI assety.
- Horní lišta sjednocena s vizuálem Zkouškomatu.
- Obrazovka „Zahájit zkoušení“ přepracována na krok 1/6.
- Výběr třídy zůstává rozbalovací pole; předmět se volí velkými arkádovými tlačítky.
- Zachována stávající logika zkoušení, návaznost na přítomnost a automatické přiřazení předmětu ke třídě.

## 2026-09-21 — Visual pass v2
- Obrazovka „Přítomnost“ převedena podle schválené pixel-art reference.
- Přidán krok 2/6, kontext třídy a předmětu, pixelové řádky žáků a výrazné stavy Přítomen / Chybí.
- Přidán živý součet přítomných a chybějících žáků.
- Seznam žáků je při větším počtu scrollovací; ostatní ovládací prvky zůstávají dostupné.
- Do losování nadále vstupují pouze přítomní žáci; původní datová logika byla zachována.
- Pokračování k pravidlům je zablokováno, pokud není přítomen žádný žák.

## 2026-09-21 — Visual pass v3
- Obrazovka „Pravidla a trestné body“ převedena podle schválených pixel-art referencí.
- Přidán krok 3/6 a kontext vybrané třídy a předmětu.
- Všichni přítomní žáci jsou v jednom scrollovacím seznamu a každý má vlastní nezávislý stav.
- Žáka lze rozbalit přímo v seznamu; jeho pravidla lze zapínat a vypínat bez opuštění obrazovky.
- Zachováno systémové potvrzení při vypnutí pravidla „Neodevzdal práci v termínu“.
- Zachován filtr pouze žáků s trestnými body, správce editovatelných pravidel a vážený výběr kandidátů.

## 2026-09-21 — Visual pass v4
- Obrazovka „Kandidáti ke zkoušení“ převedena podle schválené pixel-art reference.
- Přidán krok 4/6, kontext třídy a předmětu a tři výrazné kandidátní karty.
- Kandidát se nově nejprve označí a teprve tlačítkem „Potvrdit vybraného“ pokračuje do dalšího toku.
- Zachován vážený los, ochranný interval, možnost losovat znovu a ručně zvolit jiného žáka.
- Při shodě bodů zůstává náhodný výběr; informační panel zobrazuje aktuální režim losu.

## 2026-09-21 — Visual pass v5
- Obrazovka „Výběr tématu“ převedena podle schválené reference s Kolem štěstí.
- Přidán krok 5/6, kontext žáka, třídy a předmětu, scrollovací seznam uložených témat a vyhledávání.
- Výběr uloženého tématu již nespouští zkoušení okamžitě; téma se nejprve označí a následně potvrdí.
- Kolo štěstí losuje téma přímo do obrazovky, podporuje opakované roztočení a zachovává gamifikační událost.
- Vlastní téma lze zvolit samostatně a volitelně uložit mezi témata předmětu.
- Přidáno bezpečné finální tlačítko „Potvrdit a přejít ke zkoušení“ a návrat ke kandidátovi.

## 2026-09-21 — Visual pass v6
- Obrazovka „Průběh zkoušení“ převedena podle schválených pixel-art referencí jako krok 6/6.
- Přidán výrazný časovač, grafický průběh zbývajícího času a nezesměšňující reakce postavičky podle zbývajícího času.
- Po vypršení času se zkoušení samo neukončí; aplikace pouze výrazně upozorní a čas pokračuje.
- Přidána průběžná volitelná poznámka, která se předvyplní do závěrečného hodnocení.
- Známkování 1–5 dostalo samostatné arkádové rozhraní; stav „Vyhodit žáka od zkoušky“ se ukládá bez známky.
- Po uložení se zobrazuje samostatná obrazovka „Výsledek uložen!“ se souhrnem a volbou dalšího zkoušení nebo návratu do menu.


## 2026-09-21 — Visual fidelity H1
- Hlavní menu přestavěno podle konkrétní schválené reference „Retro pixelové menu aplikace Zkouškomat“.
- Zvětšena a zpřesněna hlavička, titul, slogan, 2×4 menu, pixelové ikony a oranžová primární dlaždice.
- Přidána spodní dekorace knih / školních skříněk a footer podle reference.
- Školní přehled byl z hlavního menu odstraněn, protože v referenčním návrhu není; data zůstávají dostupná ve Scoringu a dalších obrazovkách.
- Funkční navigace hlavního menu zůstala zachována.
## 2026-09-21 — Visual fidelity H2
- Krok 1/6 „Zahájit zkoušení“ přestavěn podle schválených referencí Výběr třídy a předmětu.
- Výběr třídy je skutečné otevírací pixelové dropdown menu s oranžově zvýrazněnou aktivní třídou.
- Předměty, souhrn výběru a hlavní tlačítko byly proporčně a barevně přiblíženy schválenému mockupu.
- V režimu zkoušení se v horní navigaci zobrazuje pouze Zpět, aby rozložení odpovídalo referenci.
- Funkční logika výběru třídy, předmětu a pokračování k přítomnosti zůstala zachována.

## 2026-09-21 — Visual fidelity H3
- Krok 2/6 „Přítomnost“ přestavěn podle konkrétní schválené reference Přítomnost žáků v Zkouškomatu.
- Řádky žáků, pixelové postavy, checkboxy a stavy Přítomen / Chybí byly proporčně a barevně zpřesněny podle předlohy.
- Nepřítomní žáci mají utlumený šedý vzhled a oranžový stav; přítomní cyan/zelené zvýraznění.
- Souhrn Přítomní / Chybí, informační panel a pokračovací tlačítko byly sjednoceny s referenční obrazovkou.
- Seznam zůstává scrollovací pro početné třídy a funkční logika přítomnosti se nemění.

## 2026-09-21 — Visual fidelity H4
- Krok 3/6 „Pravidla a trestné body“ přestavěn podle obou schválených referencí z knihovny.
- Přidán výrazný pixelový rám scrollovacího seznamu, větší řádky žáků, cyan postavy, oranžové body a přesnější rozbalení pravidel.
- Checkboxy pravidel, filtr, tlačítko „Upravit pravidla“, informační panel a hlavní oranžové tlačítko byly proporčně sjednoceny s předlohou.
- Seznam zůstává scrollovací i pro početnou třídu; každý žák si zachovává vlastní nezávislý stav pravidel.
- Funkce váženého losu, filtru a systémového potvrzení pravidla zůstaly beze změny.

## 2026-09-21 — Visual fidelity H5
- Krok 4/6 „Kandidáti ke zkoušení“ přestavěn podle schválené reference Výběr kandidáta ke zkoušení.
- Vybraný kandidát má zlatý panel s krémovým okrajem; ostatní kandidáti mají cyan pixelové panely.
- Karty byly proporčně zpřesněny: pixelová postava, označení kandidáta, jméno, výrazné body a velké oranžové tlačítko Vybrat / Vybrán.
- Informační řádek, opakování losu, hlavní potvrzení a ruční volba jiného žáka byly sjednoceny s referenčním mockupem.
- Počet předchozích zkoušení se na kartách vizuálně nezobrazuje, ale data zůstávají zachována. Vážený los a ochranný interval se nemění.

## 2026-09-21 — Visual fidelity H6
- Krok 5/6 „Výběr tématu“ přestavěn podle schválené reference s Kolem štěstí.
- Z předlohy byly použity samostatné pixelové UI assety pro titul, žáka, témata, učitele a vlastní téma; obrazovka není použita jako statické pozadí.
- Seznam témat, vyhledávání, dvousloupcové rozložení, Kolo štěstí, vylosované téma a spodní akce byly proporčně sjednoceny s referencí.
- Kolo používá pět tematických pixelových ikon a zachovává původní animaci i náhodný výběr.
- Výběr uloženého tématu, vlastní téma, volitelné uložení tématu a potvrzení do zkoušení zůstávají funkčně beze změny.

## 2026-09-21 — Visual fidelity H7
- Krok 6/6 „Zkoušení“ byl přestavěn podle schválených obrazovek probíhajícího zkoušení, známkování a uloženého výsledku.
- Probíhající zkoušení používá pixelovou postavu žáka z vizuální reference, velký oranžový časovač, stavový proužek a výrazná tlačítka Pozastavit/Pokračovat a Ukončit zkoušení.
- Průběžná poznámka byla z obrazovky zkoušení odstraněna; volitelná poznámka zůstává až ve známkování podle schváleného toku.
- Známky 1–5 jsou zobrazeny jako velká barevná pixelová tlačítka; kliknutí na známku výsledek rovnou uloží. Samostatné tlačítko Uložit výsledek se již nepoužívá.
- „Vyhodit žáka od zkoušky“ ukládá výsledek bez známky.
- Obrazovka „Výsledek uložen!“ používá zelený potvrzovací pixel-art prvek z reference a zachovává volby Další zkoušení / Zpět do hlavního menu.
- Logika historie, bodů, ochranného intervalu a vyhodnocení zkoušení zůstala zachována.

## 2026-09-21 — QA audit hlavního toku 1→6
- Ověřeny návaznosti všech akcí v hlavním zkoušecím toku; nebyla nalezena žádná neobsloužená tlačítka.
- Opraven přechod „Ukončit zkoušení“ → známkování: časovač se při otevření známkování zmrazí a do výsledku se nezapočítává čas strávený hodnocením.
- Pokud se učitel ze známkování vrátí zpět ke zkoušení, časovač se obnoví ze stejného zbývajícího času; pokud byl pozastaven už předtím, zůstane pozastavený.
- Uložený čas ukončení zkoušení nyní odpovídá okamžiku přechodu do známkování.

## 2026-09-21 — H4.1 Přehlednější podmínky žáků
- Obrazovka „Pravidla a trestné body“ byla upravena podle praktického testu ve třídním seznamu.
- Žáci se po otevření obrazovky už automaticky nerozbalují; každý je zobrazen jako čistý řádek se jménem, aktuálními body a samostatným tlačítkem „Upravit podmínky“.
- Podmínky se zobrazují pouze u jednoho vybraného žáka. Detail má vlastní souhrn bodů a tlačítko „Hotovo“ pro rychlé sbalení.
- Přidán přehled počtu přítomných žáků a počtu žáků s trestnými body.
- Body se nadále počítají automaticky ze zaškrtnutých podmínek; filtr, systémová pravidla a vážený los zůstávají funkčně beze změny.

## 2026-09-22 — H7.1 Animovaný žák při zkoušení
- Statický obrázek žáka byl nahrazen živou pixelovou postavičkou napojenou přímo na zbývající čas.
- Nad 55 % času je žák klidný; mezi 20–55 % času je nervózní; pod 20 % času se výrazněji třese a potí.
- Stav se mění automaticky během běžícího časovače bez obnovení obrazovky.
- Při pozastavení zkoušení se animace zastaví a po pokračování naváže podle aktuálního zbývajícího času.


## 2026-09-22 — Visual fidelity H8 — Moje třídy
- Sekce „Moje třídy“ byla převedena do stejného pixelového vizuálu jako hlavní zkoušecí tok.
- Třídy se zobrazují jako samostatné velké karty se školním rokem, počtem žáků, počtem předmětů a přehledem přiřazených předmětů.
- Přidán horní souhrn počtu tříd, unikátních žáků a přiřazených předmětů.
- Detail třídy byl sjednocen do stejného stylu; karty žáků mají přehledné jméno, body a oddělené akce Upravit / Odebrat.
- Záložky Žáci / Témata / Nastavení byly zvětšeny a optimalizovány pro dotykové ovládání.
- Funkce přidání třídy, otevření třídy, správy žáků, témat, nastavení, historie a převodu školního roku zůstaly zachovány.

## 2026-09-22 — Visual Pack A — H9/H10/H11
- Větší společný patch sjednocuje sekce „Moje předměty“, „Známkování“ a „Scoring / Přehledy“, aby nebylo nutné instalovat tři samostatné balíčky.
- Moje předměty dostaly velké pixelové karty, souhrn předmětů/témat/přiřazení a přepracovaný detail předmětu s přehlednými tématy a třídami.
- Známkování má nový výrazný panel filtrů, souhrn žáků/záznamů/průměru, jasné přepnutí Tabulka/Seznam a oddělené akce Tisk/PDF a Export Excel.
- Scoring má nové tři velké režimy Žáci – moje třídy / Žáci – celá škola / Učitelé a sjednocené tabulky a panely.
- Dlouhé klasifikační a scoringové tabulky zůstávají na mobilu scrollovací uvnitř vlastního rámu.
- Původní datová logika, filtry, exporty, gamifikace, témata a všechny akce zůstávají zachovány.

## 2026-09-22 — Visual Pack B — H12/H13 + závěrečný audit
- Sborovna byla převedena do stejného pixelového vizuálu jako hlavní části aplikace: velký chat, výrazné vlastní/cizí zprávy, stav online/offline, rychlé emoji a oddělený panel upozornění a pravidel místnosti.
- Nastavení bylo rozděleno do přehledných bloků Profil / Zkoušení / Pravidla a nástroje / Administrace / Účet a škola.
- Zachovány byly všechny původní identifikátory formulářů a akce, takže ukládání nastavení, avatary, pravidla, skříňky, notifikace i administrace fungují beze změny.
- Mobilní rozložení Sborovny i Nastavení bylo přepracováno tak, aby se panely skládaly pod sebe a ovládací prvky zůstaly dostatečně velké.
- V rámci závěrečného auditu byly zkontrolovány akce hlavních obrazovek, routy a syntaxe JavaScriptu.

## H1.1 — Hlavní menu: arkádovější nadpis, nové logo a retro pozadí
- vyměněna levá značka v horní liště za učitelskou pixel ikonu (`assets/ui/brand-teacher-logo.png`)
- přepracován nadpis `HLAVNÍ MENU` do výraznějšího arkádového stylu
- upraveno tmavé retro pozadí s jemnou mřížkou a silnější neonovou hloubkou
- doladěna horní lišta, značka aplikace a spodní dekorace domovské obrazovky
- beze změn logiky navigace a funkcí dlaždic

## 2026-09-22 — H1.2 Home style override fix
- Opraveno přepisování nového vzhledu hlavního menu starším CSS blokem.
- Finální styl je vložen na konec CSS, takže má přednost před staršími pravidly.
- Hlavní nadpis používá hranatější bezpatkový arcade vzhled.
- Dlaždice menu dostaly výraznější neonové pixelové rámy a oranžovou primární kartu.
- Pozadí bylo převedeno na hlubší tmavě modré retro pozadí s jemnou mřížkou.
- Zachována nová učitelská ikona vlevo nahoře.

## 2026-09-22 — H1.3 Obrazový nadpis a školní pozadí
- Nadpis „HLAVNÍ MENU“ už není programovaný fontem; používá samostatný PNG výřez přímo ze schváleného pixelového návrhu.
- Domovská obrazovka používá samostatný obrázkový background odvozený ze stejného schváleného návrhu, se zachovanými bočními školními dekoracemi.
- Střed pozadí je záměrně zklidněný pro skutečná interaktivní tlačítka aplikace; tlačítka zůstávají živá HTML/CSS, nejsou součástí obrázku.
- Původní spodní programovaná dekorace byla na hlavním menu skryta, aby se nedublovala s obrázkovým pozadím.
- Funkce a navigace hlavního menu zůstávají beze změny.

## 2026-09-22 — H1.4 Responsive fix pro obrázkové pozadí
- opraveno roztažení obrázkového pozadí hlavního menu
- pozadí nyní zachovává původní poměr stran a neřeže se přes `cover`
- na různých šířkách obrazovky se celý školní motiv zobrazuje jako jedna scéna
- centrální menu zůstává živé a vykresluje se nad obrázkovým pozadím

## 2026-09-22 — H1.5 Pozadí viditelnější a menu menší
- zmenšeno hlavní menu, aby nezakrývalo tolik školní scény v pozadí
- pozadí hlavní obrazovky nyní používá `contain` a lépe se přizpůsobuje viewportu
- upravena šířka hlavního sloupce, horní lišty, nadpisu a karet menu
- zachován obrázkový nadpis i klikací funkce všech tlačítek

## 2026-09-22 — H1.6 Adaptivní pozadí přes celý viewport
- doplněna adaptivní fullscreen vrstva pozadí, která se přizpůsobuje šířce i výšce obrazovky
- zachována ostrá hlavní školní scéna za menu a přidána širší krycí vrstva pro okraje monitoru i mobilu
- vyladěny opacity a pozice pozadí pro desktop i mobil
- menu zůstává živé, klikací a beze změny funkce

## 2026-09-22 — H1.7 Pozadí hlavního menu přes celý viewport
- hlavní školní scéna nyní vyplňuje celý viewport pomocí `background-size: cover`
- pokud rozměr obrázku přesáhne zařízení, výřez se automaticky přizpůsobí obrazovce
- zachována i druhá širší vrstva pozadí pro okraje, ale hlavní vrstva je nyní skutečně fullscreen
- menu, nadpis a tlačítka zůstávají beze změny funkce

## 2026-09-22 — H1.8 Nové hlavní pozadí z finální školní pracovny
- nahrazen asset `assets/ui/home-classroom-bg.png` novým finálním obrázkem noční pixelové školní pracovny
- zachováno chování fullscreen `cover`, takže se nové pozadí automaticky přizpůsobuje monitoru i mobilu
- beze změny logiky hlavního menu, tlačítek a obrázkového nadpisu

## 2026-09-22 — H1.9 Úprava hlavičky a navigačních ikon
- změněn slogan na „Proč zkoušet jednoduše, když to lze složitě.“ na hlavním menu i úvodní obrazovce
- do hlavičky celé aplikace přidána trvale viditelná informace o přihlášení: role a jméno uživatele
- doplněna ikona Domů pro rychlý návrat na hlavní obrazovku
- přepracováno tlačítko profilu / nastavení novou pixelovou ikonou
- tlačítko odhlášení má nově samostatnou dveřní ikonu místo vzhledu ozubeného kolečka

## 2026-09-22 — H1.10 Zjednodušená horní lišta
- přepracována horní lišta celé aplikace do jednodušší a učesanější podoby
- odstraněn rušivý kontextový řádek v hlavičce
- sjednocena velikost a vzhled ikon Domů, Profil a Odhlášení
- zmenšena a vizuálně uklizena informace o přihlášeném uživateli
- upraveny rozestupy, výšky a chování lišty na desktopu i mobilu

## 2026-09-22 — H1.11 Šipka Zpět v horní liště
- textová navigace Zpět byla nahrazena oranžovou ikonou šipky v horní liště
- nová šipka Zpět se zobrazuje napříč aplikací na všech obrazovkách kromě hlavního menu
- spodní textový pruh se zpětnou navigací byl odstraněn, aby byla aplikace čistší a jednotnější
- sjednoceno chování návratu v celém průchodu aplikací přes jednu horní lištu

## 2026-09-22 — H1.12 Finální ikona Zpět
- nahrazena provizorní oranžová šipka novou schválenou bílou pixelovou ikonou s cyan zvýrazněním
- nový asset `assets/ui/nav-back-white.png` má průhledné pozadí
- tlačítko Zpět je nyní vizuálně sjednocené s ostatními ikonami horní lišty
- chování návratu napříč aplikací zůstává beze změny

## 2026-09-22 — H1.13 Arkádové názvy všech obrazovek
- sjednoceny hlavní názvy obrazovek do hranatého bezpatkového arcade stylu podle vizuálu „HLAVNÍ MENU“
- odstraněn patkový vzhled nadpisů v hlavním toku zkoušení, třídách, předmětech, známkování, scoringu, sborovně, nastavení, nápovědě, historii a správě školy
- přidán krémový text, oranžový 3D stín a tmavá pixelová hrana
- nadpisy zůstávají živý text a responzivně se přizpůsobují desktopu i mobilu

## 2026-09-22 — H1.14 Sjednocená typografie ovládání
- sekundární nadpisy, karty a názvy položek byly převedeny na hranatý bezpatkový arcade styl
- hlavní tlačítka, záložky a volby napříč aplikací používají jednotný výrazný sans-serif font
- malé technické štítky, kroky a stavové údaje zůstávají monospace/pixelové kvůli přehlednosti
- formulářové a běžné texty nebyly zbytečně stylizovány, aby zůstaly dobře čitelné

## 2026-09-22 — H1.15 Sjednocení designu Kola štěstí
- sjednocen vzhled obrazovky Výběr tématu a samostatného Kola štěstí se zbytkem aplikace
- okna, panely a tlačítka používají stejné rámy, barvy a stíny jako ostatní části ZZ-01
- přepracována samostatná stránka Kolo štěstí do přehlednějšího panelového rozložení
- sjednoceny akční tlačítka pro losování témat, vlastní téma i potvrzovací akce

## 2026-09-22 — H1.16 Kolo štěstí: stejné kolo jako ve zkoušení
- samostatná obrazovka Kolo štěstí nově používá stejné grafické kolo jako krok Výběr tématu při zkoušení
- samostatné losování tématu zobrazuje stejné ikonky témat, ukazatel a animaci otáčení
- tlačítko Roztočit kolo bylo nahrazeno stejným stylem akčního tlačítka jako ve zkoušení

## 2026-09-22 — H1.17 Hotfix startu po loadingu
- opravena runtime chyba samostatného Kola štěstí: pomocná funkce pro výběr ikon témat je nyní společná pro zkoušení i samostatné kolo
- odstraněno zaseknutí na loading obrazovce při obnovení aplikace, pokud byla poslední otevřená stránka Kolo štěstí
- přidána bezpečnostní pojistka startu: při neočekávané chybě obnovené stránky se aplikace vrátí do hlavního menu místo trvalého loadingu

## 2026-09-22 — Audio Pack A: hudba + systémové zvuky
- přidána uživatelská skladba `zz01-theme.mp3` jako hudební smyčka hlavního menu
- do horní lišty celé aplikace přidán samostatný přepínač hudby s ikonou noty
- přidán samostatný přepínač systémových zvuků s ikonou reproduktoru
- stav hudby i systémových zvuků se ukládá do nastavení a zachová po opětovném spuštění
- přidány retro systémové zvuky pro kliknutí, potvrzení, varování, losování a uložení výsledku
- hudba se automaticky pozastaví mimo hlavní menu a při skrytí aplikace
- stejné volby jsou dostupné také na obrazovce Nastavení

## 2026-09-22 — Audio Pack B: tlumené křídové SFX + časnější start hudby
- původní pískavé systémové zvuky nahrazeny tlumenými samply inspirovanými psaním a škrtnutím křídy
- zachován jemný arkádový charakter pomocí nízkých 8bitových tónů bez ostrých výšek
- snížena hlasitost systémových zvuků
- hudba hlavního menu se nově zkouší spustit už během úvodního loadingu
- doplněny další bezpečné pokusy o spuštění hudby při načtení stránky a při prvním uživatelském gestu pro prohlížeče blokující autoplay

## 2026-09-22 — Audio Pack C: křída + školní mechanika
- kompletně nahrazeny systémové zvuky po zpětné vazbě na příliš hluboké Audio Pack B
- odstraněny hluboké tónové efekty; nové samply jsou soustředěné do příjemnějšího středního pásma
- běžné kliknutí: krátké suché mechanické ťuknutí s jemným dotekem křídy
- potvrzení: dvojitý křídový tah připomínající fajfku
- varování: dvě krátká mechanická klepnutí bez dunění
- losování: zpomalující série křídových doteků
- výsledek: krátký křídový tah a lehké školní razítko
- hudba a její automatický start z Audio Pack B zůstávají beze změny

## 2026-09-22 — Audio Pack D: jemný melodický zvukový styl
- systémové zvuky přepracovány do jednotnějšího, měkčího melodického stylu bez ostrých arkádových pípnutí a hlubokého dunění
- běžné kliknutí používá jemné mechanické ťuknutí s teplým tónem
- potvrzení, varování a výsledek používají krátké příjemné dvou- až třínotové motivy
- přidán samostatný magický zvuk při objevení Školní skříňky
- Kolo štěstí nově používá jemné cvakání, které se během otáčení postupně zpomaluje, a na konci zazní měkké melodické potvrzení
- hudba hlavního menu zůstává beze změny

## 2026-09-22 — Audio Pack D.1: fanfára za trofej
- přidána krátká melodická vítězná fanfára `sfx-trophy-fanfare.wav`
- fanfára zazní pouze při skutečném odemčení nové trofeje nebo jejího nového stupně
- zvuk je sladěný s jemnějším melodickým stylem Audio Packu D a nepoužívá ostré 8bitové pípání

