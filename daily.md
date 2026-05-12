---
description: Codzienny briefing PM-a — Slack Later, kalendarz, Gmail, taski specjalistów
argument-hint: "[opcjonalnie: dzisiaj / tydzien]"
model: claude-opus-4-7
---

Zrob przeglad otwartych spraw Krystiana Stefaniuka (PM, Agencja Whites) i przygotuj zwiezle podsumowanie co wymaga akcji.

## Krok 1: Slack Later — zapisane watki

Wyszukaj zapisane/oznaczone watki uzywajac `slack_search_public_and_private` z zapytaniem `is:saved`.

Dla kazdego znalezionego watku uzyj `slack_read_thread` zeby zrozumiec kontekst:
- O co chodzi w tym watku?
- Co wisi bez akcji?
- Kto ma cos zrobic — Krystian czy specjalista?

## Krok 2: Wzmianki bez follow-upu

Wyszukaj przez `slack_search_public_and_private`:
- Zapytanie: `to:me` lub `@Krystian` z ostatnich 7 dni
- Szukaj tez odpowiedzi Krystiana w stylu "zajme sie", "dam znac", "later", "sprawdze" — te sa sygnalem ze cos wisi

Dla znalezionych watkow sprawdz czy doszlo do finalizacji.

## Krok 3: Kalendarz — co wymaga przygotowania

Sprawdz `list_events` na najblizsze 3 dni. Dla kazdego spotkania oceń:
- Czy jest agenda?
- Czy sa materialy / dane do pokazania?
- Czy to status z klientem — co nowego od ostatniego razu?

## Krok 4: Gmail — nieodpowiedziane maile z akcja

Wyszukaj przez `search_threads`:
- Maile nieodpowiedziane starsze niz 24h
- Maile z pytaniem lub prosba o decyzje
- Maile od klientow bez odpowiedzi

## Krok 5: Pogrupuj i przedstaw digest

Pogrupuj wszystko w trzech sekcjach:

### Dzisiaj (pilne)
- [task / sprawa] — skad pochodzi (Slack Later / Gmail / Kalendarz) — krotki kontekst

### Ten tydzien (wazne, nie pilne)
- [task / sprawa] — skad pochodzi — krotki kontekst

### Do podbicia specjalistow
- [imie specjalisty] — [co wisi] — [od kiedy] — [skad wiadomo]

Jezeli lista jest pusta w danej sekcji — napisz krotko "brak".

## Krok 6: Akcja

Po przedstawieniu digestu zapytaj:

"Co chcesz zrobic?
a) Wygenerowac drafty reminderow do specjalistow
b) Nic wiecej — dzieki, mam co potrzebowalem"

Jezeli opcja (a):
- Dla kazdego specjalisty z sekcji "Do podbicia" wygeneruj krotka wiadomosc Slack (styl jak w /reminder)
- Pokaz drafty i zapytaj: "Wyslac do [imie]? (tak/nie)"
- Wyslij po potwierdzeniu przez `slack_send_message`

## Zasady:
- Skupiaj sie na rzeczach z ostatnich 14 dni — starsze prawdopodobnie juz nieaktualne
- Pomijaj watki z aktywnoscia z ostatnich 2h — sa swiezo ogarniane
- Jezeli brak danych z jakiegos zrodla — napisz "nie znaleziono nowych spraw w [zrodle]"
- Nie wysylaj zadnych wiadomosci bez potwierdzenia Krystiana
- Nie generuj reminderow dla samego Krystiana — tylko do specjalistow wykonawczych
