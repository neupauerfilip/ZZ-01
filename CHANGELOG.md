# ZZ-01_EXAM_SCENE_E_VIDEO_BASED_SCENE_REBUILD

## Proč vznikl tento patch
Video z reálného běhu ukázalo, že samostatné CSS-positioned postavy se při vykreslení neposazují spolehlivě k nábytku v pozadí. Tento patch proto mění princip scény.

## Co se mění
- učitel a žák už nejsou během zkoušení samostatné absolutně pozicované obrázky
- aplikace přepíná celé připravené 16:9 scénické snímky
- každá scéna má postavy už pevně umístěné vůči katedře, tabuli a dveřím
- klid: učitel za katedrou, žák u tabule
- kontrola: učitel u tabule
- nervozita / závěr: samostatné celé scénické snímky
- konec času a přesčas: samostatné celé scénické snímky
- velká časomíra je znovu postavená jako samostatný HUD panel s nulovým záporným letter-spacingem a bez ořezu

## Test
1. zahájit zkoušení
2. projít countdown 3-2-1-FIGHT
3. ověřit klidovou scénu
4. nechat doběhnout čas do nervózní fáze
5. ověřit 0:00 a přesčas
6. změnit velikost okna – postavy musí zůstat na stejném místě vůči učebně
