---
description: Rozliczenie projektu klienta — zakres, koszty, deliverables vs. umowa
argument-hint: "[nazwa-klienta] [opcjonalnie: miesiac/okres]"
model: claude-opus-4-7
---

Przygotuj rozliczenie projektu dla klienta: **$ARGUMENTS**

## Krok 1: Znajdz umowe i zakres

Wyszukaj na Google Drive przez `search`:
- "$ARGUMENTS umowa"
- "$ARGUMENTS oferta"
- "$ARGUMENTS zakres"
- "$ARGUMENTS wycena"

Wyciagnij z dokumentu:
- Co Whites zobowiazalo sie dostarczac w danym okresie
- Ustalone stawki / budzet
- Liczbe materialow / godzin jezeli wycena itemizowana

## Krok 2: Sprawdz co zostalo zrealizowane

**Google Drive** — wyszukaj przez `search`:
- "$ARGUMENTS raport"
- "$ARGUMENTS podsumowanie"
- "$ARGUMENTS faktura"

Szukaj plikow potwierdzajacych wykonanie pracy (raporty, gotowe materialy, wyniki kampanii).

**Slack** — wyszukaj kanaly klienta (`slack_search_channels`). Dla kazdego kanalu uzyj `slack_read_channel`. Szukaj:
- Potwierdzen dostarczonych elementow
- Wiadomosci o zakonczeniu prac ("gotowe", "wyslane", "opublikowane", "zaakceptowane")
- Ewentualnych zmian zakresu w trakcie miesiac

**Gmail** — wyszukaj przez `search_threads` maile z nazwa klienta. Szukaj:
- Wyslanych materialow jako zalaczniki lub linki (raporty, prezentacje, pliki)
- Akceptacji klienta ("ok", "dzieki", "zaakceptowane", "wyglada dobrze", "mozecie fakturowac")
- Potwierdzen ustalen dotyczacych zakresu lub zmian
- Wazne: czesc dowodow dostarczenia pracy moze istniec TYLKO w mailach — traktuj je rownowaznie z Drive i Slackiem, nie oznaczaj elementu jako brak realizacji jesli nie sprawdziles maila

**BlueDot** — wyszukaj spotkania (`search_meetings`). Sprawdz action items i notatki pod katem:
- Dodatkowych prac nieuwzglednionych w umowie
- Ustalonych zmian zakresu
- Potwierdzenia akceptacji materialow przez klienta

## Krok 3: Zbierz zestawienie

Stworz zestawienie wykonanych prac:

| Element | Czy w umowie? | Dostarczone? | Uwagi |
|---------|--------------|--------------|-------|
| [np. 4 posty SM] | ✅ Tak | ✅ Tak / ❌ Nie / 🔄 Czesciowo | [link/dowod lub brak] |

Dodaj sekcje dla prac dodatkowych (spoza umowy) — jezeli sa.

## Krok 4: Przedstaw podsumowanie rozliczenia

### Rozliczenie: [Nazwa klienta] — [Okres]
**Podstawa:** [dokument umowy — nazwa + link]

### Zrealizowano zgodnie z umowa:
- [lista z potwierdzeniami]

### Niezrealizowane (do wyjasnienia):
- [lista z powodem jezeli znany]

### Prace dodatkowe (poza umowa):
- [lista — do ewentualnej refaktury lub dokumentacji]

### Status rozliczenia:
- Czy wszystkie elementy z umowy zostaly dostarczone? [TAK / NIE / CZESCIOWO]
- Czy sa podstawy do wystawienia FV zgodnie z umowa? [TAK / NIE / WYMAGA WYJASNIENIA]

## Krok 5: Akcja

Zapytaj:
"Co chcesz zrobic?
a) Wyeksportuj zestawienie do Google Sheets
b) Zapisz jako Google Doc
c) Wyslij podsumowanie do zespolu na Slack
d) Nic wiecej — dzieki"

## Zasady:
- Nie wnioskuj o wykonaniu pracy bez konkretnego dowodu
- Jezeli nie mozna potwierdzic dostarczenia — oznacz jako ❓ a nie ❌
- Rozliczenie obejmuje okres z argumentu lub domyslnie biezacy miesiac
- Prace dodatkowe notuj osobno — nie mieszaj z zakresem umowy
- Nie oceniaj jakosci pracy — tylko fakt dostarczenia
