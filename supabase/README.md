# Supabase – ZZ-01

## Fáze 1
Tato složka připravuje základ pro skutečné účty a školy. Současná aplikace zatím dál používá lokální data přes `dataStore`, takže se chování prototypu nemění.

### Co založí `001_foundation.sql`
- uživatelské profily,
- školy,
- členství učitelů ve škole,
- role `admin` / `teacher`,
- stavy žádosti `pending` / `approved` / `rejected`,
- RLS pravidla pro oddělení škol,
- funkci `create_school(...)`, která založí školu i prvního admina.

## Další krok
1. Vytvořit nový Supabase projekt.
2. V SQL Editoru spustit `001_foundation.sql`.
3. Zkopírovat **Project URL** a **Publishable key**.
4. Nikdy nedávat `service_role` / secret key do `index.html`.
5. Poté připojíme skutečné přihlášení v aplikaci.

Až ověříme Auth, přidáme další migraci pro třídy, žáky, předměty, zkoušení a inventář.
