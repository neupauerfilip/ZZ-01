ZZ-01 — SYNC V2

Co opravuje:
- první načtení školy je server-first,
- background synchronizace už plošně nemaže předměty ani vazby předmět–třída,
- explicitní vytvoření/upravení/odebrání předmětu používá rozdílovou synchronizaci,
- teacher_class_assignments vkládá jen chybějící vazby místo opakovaného UPSERTu.

Použití:
1. Rozbal ZIP.
2. Zkopíruj apply_sync_v2.bat a apply_sync_v2.ps1 do kořene projektu ZZ-01 vedle index.html.
3. Spusť apply_sync_v2.bat.
4. V GitHub Desktop zkontroluj změnu index.html.
5. Commit: stabilizace synchronizace školní struktury
6. Push origin.
