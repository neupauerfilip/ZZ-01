# ZZ-01 Header Menu Pro Refinement

## Co patch upravuje
- vrací hlavní význam logotypu **ZKOUŠKOMAT** do levé části hlavičky a vycentruje jej vizuálně v rámci levého bloku,
- na **hlavním menu** přesouvá informační okno s uživatelem a školou **pod řadu ovládacích ikon**,
- sjednocuje hlavičku hlavního menu s ostatními obrazovkami čistším profesionálnějším rozvržením,
- zachovává kompaktní výšku hlavičky bez zbytečného zvětšování,
- ponechává ostatní obrazovky funkčně beze změny, mění pouze rozložení home headeru.

## Technicky
- upraven renderer `layout(...)` v `index.html`,
- přidán dvouřádkový `session-chip` s údaji:
  - Přihlášen: role + jméno,
  - Škola: název školy,
- přidány CSS override styly pro `home-topbar`, `home-actions-stack` a kompaktní zarovnání ikon.

## Doporučený commit
`Refine home header layout and move session panel below icons`
