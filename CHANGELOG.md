# ZZ-01_EXAM_SCENE_D_ANCHOR_LAYER_TIMER_REBUILD

## Co patch opravuje
- opravuje kotvení postav ve scéně zkoušení
- učitel sedí skutečně za levou katedrou v úvodní klidové fázi
- žák je ukotvený před tabulí a píše do reálné oblasti tabule
- opravuje masku katedry tak, aby spodní část učitele byla schovaná za katedrou
- nahrazuje problematické sprite assety čistšími výřezy z jednotné sprite sady
- zvětšuje a stabilizuje velkou časomíru, aby se neořezávala
- dolaďuje průběh animace tak, aby učitel na začátku více seděl / sledoval a až později chodil kontrolovat tabuli

## Instalace
1. Rozbal ZIP do kopie projektu.
2. Přepiš soubor `index.html`.
3. Přepiš složku `assets/ui/` soubory z tohoto patche.
4. Otestuj průchod: loading -> zahájit zkoušení -> countdown -> samotné zkoušení.

## Test po instalaci
- po spuštění zkoušení musí učitel sedět vlevo za katedrou
- žák musí stát před tabulí na pravé straně
- velká časomíra musí být čitelná a nesmí být uříznutá
- po blížícím se konci času musí žák přejít do nervóznějšího stavu
- po vypršení času musí učitel ukázat směrem ke dveřím
