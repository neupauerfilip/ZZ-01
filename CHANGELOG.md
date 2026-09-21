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
