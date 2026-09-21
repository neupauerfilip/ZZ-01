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
