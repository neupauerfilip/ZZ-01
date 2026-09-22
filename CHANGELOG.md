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

