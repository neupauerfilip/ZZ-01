# Supabase – ZZ-01

Databázové migrace Zkouškomatu se aplikují postupně podle čísel souborů. Produkční Supabase projekt je již napojený na webovou aplikaci přes Project URL a publishable key. Secret/service-role klíč nepatří do `index.html`.

## Aktuální stav

- `001_foundation.sql` – profily, školy a členství učitelů
- `002_security_hardening.sql` – přesun interních helperů do neveřejného schématu `private`
- `003_school_search_rpc.sql` – bezpečné vyhledání školy
- `004_my_memberships_rpc.sql` – členství právě přihlášeného uživatele
- `005_teacher_membership_admin.sql` – skutečné schvalování a správa učitelů
- `006_school_structure_students.sql` – sdílené třídy, žáci, zápisy do tříd, přiřazení učitelů a předmětů; příprava na žákovské účty a bodový ledger
- `007_school_structure_refinements.sql` – samostatný katalog předmětů učitele a zpřesnění vazeb budoucí bodové historie

## Datový princip

Třídy a identity žáků jsou školní data. Učitel si k nim vytváří vlastní přiřazení tříd a předmětů. Aktuální body, inventář, témata, známky a historie zkoušení se zatím ukládají lokálně a budou postupně přesunuty do dalších Supabase tabulek.

Žák má už nyní stabilní serverové UUID. Tabulka `student_accounts` je připravená pro budoucí propojení tohoto žáka s jeho vlastním přihlášením. Tabulka `student_point_events` je připravená jako neměnná historie bodových událostí z testů, výzev, pravidel, skříněk a dalších zdrojů.
