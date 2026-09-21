# Ochrana dat — vývojové zásady ZZ-01

Zkouškomat může v produkčním provozu pracovat se školními údaji. Tento repozitář je ale **zdrojový projekt**, nikoli databáze.

## Do GitHubu nepatří

- skutečná jména a identifikátory žáků,
- známky a historie konkrétních žáků,
- osobní e-maily používané pro reálné účty,
- skutečné školní přístupové údaje,
- hesla, API klíče, OAuth secret, tokeny,
- exporty z reálných tříd.

## Ve zdrojovém kódu lze mít

- smyšlená testovací data,
- anonymizované příklady,
- strukturu datového modelu,
- statické designové reference,
- testovací konfiguraci bez tajných údajů.

## Před produkčním nasazením

Je potřeba samostatně navrhnout autentizaci, oprávnění, izolaci škol, databázi, zálohování, audit změn a pravidla uchovávání dat. Produkční architektura není nahrazena tím, že prototyp používá `localStorage`.
