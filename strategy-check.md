---
description: Weryfikacja realizacji strategii klienta — Drive, Slack, BlueDot
argument-hint: "[nazwa-klienta]"
model: claude-opus-4-7
---

Sprawdz poziom realizacji strategii dla klienta: **$ARGUMENTS**

## Krok 1: Znajdz strategie klienta na Google Drive

Wyszukaj dokumenty strategiczne uzywajac `search` z zapytaniami:
- "$ARGUMENTS strategia"
- "$ARGUMENTS strategy"
- "$ARGUMENTS plan"
- "$ARGUMENTS brief"

Przejrzyj wyniki i wybierz najbardziej aktualny dokument strategiczny (najczesciej Google Doc lub PDF). Jezeli jest kilka — wylistuj je i zapytaj uzytkownika ktory jest wlasciwy.

Jezeli nie znaleziono — przeszukaj strukture folderow:
- Uzyj `list_drives`, potem `list_folder` dla folderow klientow
- Szukaj folderu z nazwa klienta, nastepnie dokumentow strategicznych w srodku

## Krok 2: Przeczytaj strategie

Przeczytaj wybrany dokument strategiczny. Wyciagnij z niego:

**Cele strategiczne** — co mialo byc osiagniete (KPI, cele biznesowe, cele komunikacyjne)

**Dzialania / taktyki** — co konkretnie mialo byc zrobione (kampanie, tresci, SEO, social media, itd.)

**Harmonogram** — jezeli jest, jakie dzialania mialy byc kiedy

**Budzet / zakres** — jezeli jest, jaki byl planowany zakres prac

Jezeli dokument jest rozlegly — skup sie na sekcjach z celami i planem dzialan.

## Krok 3: Sprawdz co zostalo zrealizowane

**Slack** — wyszukaj kanaly klienta (`slack_search_channels` z nazwa klienta). Dla kazdego kanalu uzyj `slack_read_channel` (limit: 200 wiadomosci). Szukaj:
- Wysylki materialow, publikacji, zakonczonych kampanii
- Raportow i podsumowaniowych wiadomosci
- Potwierdzen deliverables ("wyslalem", "gotowe", "opublikowane", "zaakceptowane", "done", "sent")
- Blokad i opóznien

**BlueDot** — wyszukaj spotkania z klientem (`search_meetings` z nazwa klienta). Szukaj w action items i notatkach:
- Co bylo omawiane jako zrealizowane
- Co zostalo odlozone lub zmienione
- Feedbacku klienta na temat dzialan

**Google Drive** — wyszukaj pliki zwiazane z klientem, ktore wskazuja na realizacje:
- Raporty miesięczne / kwartalne
- Gotowe materialy (grafiki, teksty, prezentacje)
- Wyniki kampanii

## Krok 4: Porownaj plan z realizacja

Dla kazdego dzialania / taktyki ze strategii oceń:

| Dzialanie | Status | Dowody realizacji | Uwagi |
|-----------|--------|-------------------|-------|
| [z dokumentu] | ✅ Zrealizowane / 🔄 W trakcie / ❌ Niezrealizowane / ❓ Brak danych | [skad wiadomo] | [blokady, zmiany zakresu] |

## Krok 5: Przedstaw podsumowanie

Zaprezentuj wyniki w formacie:

### Strategia: [Nazwa klienta]
**Dokument:** [nazwa + link]
**Okres:** [jezeli znany]

### Poziom realizacji ogolnie: X%
*(oblicz jako: liczba zrealizowanych / liczba wszystkich dzialan ze strategii)*

### Co zrealizowano:
- [lista z dowodami]

### Co w trakcie:
- [lista z aktualnym statusem]

### Co niezrealizowane lub nieznane:
- [lista z powodem jezeli znany]

### Rekomendacje:
- [co wymaga uwagi PM-a, co trzeba podbic, co moze byc zagrozeniem]

## Krok 6: Akcja

Zapytaj:
"Co chcesz zrobic z tym podsumowaniem?
a) Wyeksportuj do Google Sheets / Google Doc
b) Wyslij Slack do zespolu
c) Nic wiecej — dzieki"

## Zasady:
- Nie oceniaj dzialan jako "zrealizowane" bez konkretnego dowodu (wiadomosc, plik, raport)
- Jezeli brakuje danych dla jakiegos dzialania — oznacz jako ❓ i napisz skad moglby byc dowod
- Nie zmieniaj oceny strategii — tylko weryfikuj realizacje, nie jakosc
- Jezeli strategia ma wiele projektow / klientow w jednym dokumencie — skup sie tylko na $ARGUMENTS
- Jezeli dokument strategii jest niedostepny lub zbyt ogolny — poinformuj i zapytaj czy kontynuowac z tym co jest
