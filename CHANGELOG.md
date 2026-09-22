# ZZ-01 – oprava hlavičky hlavního menu

Tento patch nahrazuje předchozí chybný pokus o rozložení home headeru.

- hlavní menu má pevnou kompaktní hlavičku vysokou 80 px,
- vlevo je pouze vycentrovaný titul ZKOUŠKOMAT,
- vpravo je nahoře řada 5 ovládacích ikon,
- přímo pod ikonami je jediný nízký informační proužek Uživatel • Škola,
- informační proužek neroztahuje výšku hlavičky,
- ostatní obrazovky zůstávají beze změny.

Doporučený commit:
Fix home header layout without increasing height
