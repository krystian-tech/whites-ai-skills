---
description: Stworz roadmape projektowa dla klienta
argument-hint: "[nazwa-klienta]"
model: claude-opus-4-7
---

Stworz roadmape projektowa dla klienta: **$ARGUMENTS**

## Krok 1: Znajdz kanaly Slack klienta

Wyszukaj kanaly Slack zawierajace nazwe klienta (lub jej warianty) uzywajac `slack_search_channels`.

- Szukaj roznych wariantow nazwy (np. dla "Knauf" szukaj "knauf", dla "BMI" szukaj "bmi")  
- Zapisz nazwy i ID znalezionych kanalow  
- Wylistuj znalezione kanaly uzytkownikowi i zapytaj czy sa kompletne, czy cos dodac

## Krok 2: Skan zrodel informacji

Rownoleglee przeskanuj wszystkie dostepne zrodla:

### 2a. Slack — kanaly projektowe

Dla kazdego znalezionego kanalu uzyj `slack_read_channel` (limit: 200 wiadomosci). Szukaj:

- Taskow, ustalen, decyzji  
- Blockerow i zaleznosci  
- Deadlinow i terminow  
- Przypisanych osob (kto co robi)

### 2b. BlueDot — notatki ze spotkan

Wyszukaj na Google Drive dokumenty BlueDot dotyczace klienta:

- `drive_search` z nazwa klienta  
- Odczytaj znalezione dokumenty (`docs_getText`)  
- Wyciagnij action items, ustalenia, decyzje

### 2c. Gmail — korespondencja

Wyszukaj maile dotyczace klienta:

- `gmail_search` z nazwa klienta (limit: 20 najnowszych)  
- Skup sie na action items i ustaleniach

## Krok 3: Kategoryzacja taskow

Podziel znalezione taski na obszary. Uzyj tych kategorii jako bazy (dostosuj do klienta):

- Performance  
- SEO  
- Social/Content  
- Komunikacja/Strategia  
- Analityka/Tracking  
- PM/Koordynacja

Dla kazdego taska okresl:

- **Obszar** — jedna z kategorii powyzej  
- **Task** — krotka nazwa (max 60 znakow, BEZ polskich znakow)  
- **Opis** — szczegoly, kontekst (BEZ polskich znakow)  
- **Owner** — kto jest odpowiedzialny (imie i nazwisko)  
- **Priorytet** — Krytyczny / Wysoki / Sredni / Niski  
- **Status** — To do / In progress / Blocked / Review / Done / Paused  
- **Deadline** — jesli znany (format YYYY-MM-DD)  
- **Blokowane przez** — jesli jest bloker (kto/co blokuje)  
- **Zrodlo** — skad pochodzi informacja (np. "Slack 15.03", "BlueDot 10.03", "Mail")

## Krok 4: Przedstaw draft uzytkownikowi

Przed utworzeniem arkusza, przedstaw uzytkownikowi:

1. Liste znalezionych kanalow i zrodel  
2. Liczbe znalezionych taskow per obszar  
3. Pelna liste taskow w formie tabeli markdown  
4. Zapytaj: "Czy chcesz cos dodac, usunac lub zmienic zanim stworze arkusz?"

Poczekaj na potwierdzenie uzytkownika.

## Krok 5: Stworz staging Google Doc

Po zatwierdzeniu przez uzytkownika, stworz Google Doc do przyszlych aktualizacji:

- Uzyj `docs_create` z tytulem: "\[NAZWA KLIENTA\] — Staging Taski"  
- Zapisz ID tego dokumentu — bedzie potrzebny w skrypcie .gs  
- Poinformuj uzytkownika o ID staging Doca

## Krok 6: Generowanie skryptu Apps Script

Wygeneruj skrypt Apps Script analogiczny do `~/Desktop/payback_roadmapa.gs`.

Szablon CONFIG:

```
var CONFIG = {
  projectName: '[NAZWA KLIENTA]',
  stagingDocId: '[ID STAGING DOCA Z KROKU 5]',
  teamMembers: [/* lista osob z taskow */],
  areas: [/* obszary uzyte w taskach */],
  statuses: ['To do', 'In progress', 'Blocked', 'Review', 'Done', 'Paused'],
  priorities: ['Krytyczny', 'Wysoki', 'Sredni', 'Niski']
};
```

Skrypt MUSI zawierac nastepujace funkcje:

### setup()

Tworzy zakladke Taski + Dashboard. Usuwa domyslny arkusz.

### createTasksSheet(ss)

- Wstawia wszystkie taski znalezione w kroku 3  
- Data validation na kolumnach: Status, Priorytet, Owner, Obszar  
- Formatowanie warunkowe: Blocked (czerwony), Done (zielony), In progress (zolty), Review (niebieski), Paused (fioletowy), Overdue (ciemnoczerwony)  
- Filtry, zawijanie tekstu w kolumnie Opis  
- Szerokosci kolumn jak w payback\_roadmapa.gs

### createDashboardSheet(ss)

- Liczniki statusow (Done, In progress, Blocked, To do, Paused, Review)  
- RAZEM i Overdue  
- Obciazenie per osoba (otwarte + blocked)  
- Kolory tla per status

### importNewTasks()

KLUCZOWA FUNKCJA — importuje nowe taski ze staging Google Doca:

```javascript
function importNewTasks() {
  var doc = DocumentApp.openById(CONFIG.stagingDocId);
  var body = doc.getBody().getText().trim();

  if (!body || body.length === 0) {
    SpreadsheetApp.getUi().alert('Brak nowych taskow do zaimportowania.');
    return;
  }

  var sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('Taski');
  var lines = body.split('\n');
  var newTasks = [];

  for (var i = 0; i < lines.length; i++) {
    var line = lines[i].trim();
    if (line.length === 0) continue;
    var cols = line.split('|');
    if (cols.length >= 10) {
      var row = [];
      for (var j = 0; j < 10; j++) {
        row.push(cols[j].trim());
      }
      // Konwertuj ID na numer
      row[0] = parseInt(row[0], 10);
      newTasks.push(row);
    }
  }

  if (newTasks.length === 0) {
    SpreadsheetApp.getUi().alert('Nie znaleziono poprawnych taskow w staging doc.');
    return;
  }

  var lastRow = sheet.getLastRow();
  sheet.getRange(lastRow + 1, 1, newTasks.length, 10).setValues(newTasks);

  // Wyczysc staging doc
  doc.getBody().clear();

  SpreadsheetApp.getUi().alert('Zaimportowano ' + newTasks.length + ' nowych taskow (ID ' + newTasks[0][0] + ' - ' + newTasks[newTasks.length - 1][0] + ').');
}
```

### onOpen()

Menu z DWOMA przyciskami:

```javascript
function onOpen() {
  SpreadsheetApp.getUi()
    .createMenu('[NAZWA KLIENTA]')
    .addItem('Importuj nowe taski', 'importNewTasks')
    .addToUi();
}
```

Zapisz skrypt jako `~/Desktop/[nazwa_klienta_lowercase]_roadmapa.gs`

## Krok 7: Instrukcja dla PM-a

Wyswietl instrukcje:

### Pierwszy setup (jednorazowo):

1. Otworz sheets.new  
2. Rozszerzenia → Apps Script  
3. Wklej kod z pliku `[nazwa_klienta]_roadmapa.gs`  
4. Z dropdowna wybierz `setup` → Uruchom  
5. Po przeladowaniu arkusza pojawi sie menu \[NAZWA KLIENTA\]

### Aktualizacja (powtarzalne):

1. Napisz w Claude Code: "zaktualizuj roadmape \[nazwa klienta\]"  
2. Claude przeskanuje Slack, BlueDot i maile, i wrzuci nowe taski do staging Doca  
3. W arkuszu kliknij: \[NAZWA KLIENTA\] → Importuj nowe taski  
4. Gotowe!

## Krok 8: Zapisz dane roadmapy w pamieci

Zapisz w pamieci (memory) nastepujace dane do przyszlych aktualizacji:

- Nazwa klienta  
- ID arkusza Google Sheet (PM poda po utworzeniu)  
- ID staging Google Doca  
- Lista kanalow Slack (nazwy + ID)  
- Aktualny max ID taska  
- Data ostatniej aktualizacji

## WAZNE zasady:

- W kodzie Apps Script NIGDY nie uzywaj polskich znakow (a, e, l, o, s, z, z, c, n) — blokuja parser!  
- Zawsze czekaj na zatwierdzenie uzytkownika przed generowaniem skryptu  
- Jesli klient ma malo danych (< 5 taskow), poinformuj uzytkownika i zapytaj czy kontynuowac  
- Identyfikuj osoby po stronie klienta i oznaczaj je "(klient)" w ownerze  
- Format zapisu do staging Doca (pipe-delimited, jeden task per linia): `ID|Obszar|Task|Opis|Owner|Priorytet|Status|Deadline|Blokowane przez|Zrodlo` Np: `48|Performance|Nowa kampania Meta|Uruchomienie kampanii zasiegowej|Jan Kowalski|Wysoki|To do|2026-04-01||Slack 19.03`  
- Przed zapisem do staging Doca ZAWSZE sprawdz aktualny max ID w arkuszu (sheets_getRange na kolumne A) i numeruj od max+1
