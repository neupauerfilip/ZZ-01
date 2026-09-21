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
