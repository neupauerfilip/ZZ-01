ZZ-01 – žákovské přihlášení jménem a příjmením

- místo libovolného uživatelského jména se používá skutečné jméno a příjmení
- pouze písmena a mezery, bez čísel a speciálních znaků
- první aktivace ověří jméno proti evidenci žáka
- další přihlášení: kód školy + jméno a příjmení + PIN
- backendová změna je už aplikovaná v Supabase

Oprava: propojovací kód a kód školy se načtou před překreslením formuláře, takže se při odeslání neztratí.
