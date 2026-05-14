---
description: Stworz przypomnienia do specjalistow o otwartych taskach dla klienta
argument-hint: "[nazwa-klienta]"
model: claude-opus-4-7
---

Stworz przypomnienia do specjalistow o otwartych taskach dla klienta: **$ARGUMENTS**

## Krok 1: Znajdz kanaly Slack klienta

Wyszukaj kanaly Slack zawierajace nazwe klienta uzywajac `slack_search_channels`.

- Szukaj roznych wariantow nazwy
- Wylistuj znalezione kanaly i zapytaj czy sa kompletne

## Krok 2: Skan kanalow

Dla kazdego kanalu uzyj `slack_read_channel` (limit: 200 wiadomosci). Szukaj:

- Taskow przypisanych do konkretnych osob (np. "@imie zrob X", "prosba o X od @imie")
- Wzmianek o deadlinach
- Wiadomosci bez odpowiedzi (ktos prosil, nikt nie odpisał)
- Ostatnich aktualizacji per osoba — czy cos "wisi" bez ruchu
- Blokad i zaleznosci

Rownoleglee przeskanuj BlueDot (`search_meetings` z nazwa klienta) pod katem action items ze spotkan.

## Krok 3: Pogrupuj taski per specjalista

Dla kazdej osoby zbierz:
- Co ma do zrobienia (task)
- Kiedy byl ostatni ruch (data)
- Czy jest deadline
- Czy cos blokuje

Pomijaj taski oznaczone jako done lub z aktywnoscia z ostatnich 48h.

## Krok 4: Przedstaw liste przed draftem

Zanim napiszesz wiadomosci, przedstaw uzytkownikowi:

1. Liste specjalistow i ich otwartych taskow
2. Zapytaj: "Do kogo chcesz wyslac reminder? (wpisz imiona lub 'wszystkich')"

Poczekaj na potwierdzenie.

## Krok 5: Wygeneruj drafty wiadomosci Slack

Dla kazdej wybranej osoby wygeneruj wiadomosc Slack w stylu ponizej.

**Zasady stylu:**
- Zaczyna sie od "Hej @imie" lub "Ej @imie"
- Krotko i konkretnie — max 3-4 zdania lub bullet points
- Jezyk: polski
- Ton: luznyl ale wyrazny. Nie agresywny, nie dramatyczny
- Deadline podawaj konkretnie jesli znany, z lekkim humorem jesli pilny: "do konca tygodnia (czyli czwartek xd)"
- Uzyj "Prosbaa o..." jako miekki ale wyrazny task assignment
- Nie pisz elaboratow — jedna mysl, jedno zdanie
- Jesli cos jest zablokowane po stronie klienta — zaznacz to, nie obwinaj specjalisty
- Nie uzywaj emoji w odpowiedziach Claude — ale w drafcie wiadomosci :) raz na wiadomosc jest ok jesli relacja na to pozwala

**Przykladowy draft:**

> Hej @Ania, chcialam sie upewnic ze mamy to ogarniente — czy posty na maj sa juz gotowe do akceptu klienta? Jezeli tak, wrzuc prosze do czwartku, zeby miec czas na review przed weekendem :)

## Krok 6: Zapytaj co robic z draftami

Po pokazaniu wszystkich draftow zapytaj:

"Chcesz zeby wyslac ktoras z tych wiadomosci automatycznie, czy kopiujesz sam/a?"

Jezeli uzytkownik chce wyslac:
- Uzyj `slack_send_message` z ID kanalu lub DM do osoby
- Przed wyslaniem pokaz jeszcze raz tresc i popros o potwierdzenie: "Wyslac te wiadomosc do @imie? (tak/nie)"
- Wyslij po potwierdzeniu
- **WAZNE:** Oznaczenia osob w wiadomosci MUSZA byc w formacie `<@USER_ID>` (np. `<@UB2BJH2JG>`), nie jako plain text `@imie`. Tylko ten format tworzy klikalne, interaktywne oznaczenie w Slacku ktore powiadamia osobe. Przed wyslaniem znajdz user ID przez `slack_search_users` lub z historii kanalow.

## WAZNE zasady:

- Skupiaj sie na taskach z ostatnich 30 dni — starsze prawdopodobnie sa juz nieaktualne
- Jezeli task nie ma przypisanej osoby — pomijaj go
- Jezeli specjalista dal odpowiedz w ciagu 48h — nie generuj dla niego przypomnienia
- Jezeli jest wiecej niz 3 taski dla jednej osoby — skompresuj do najwazniejszych 2-3
- Nie generuj reminderow do PM-a ktory uruchomil skill — tylko do specjalistow wykonawczych
- Jezeli klient ma malo danych (< 3 tasków z przypisanymi osobami) — poinformuj i zapytaj czy kontynuowac
