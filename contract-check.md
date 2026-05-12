---
description: Weryfikacja umowy klienta — zakres, zobowiazania, zgodnosc z realizacja
argument-hint: "[nazwa-klienta]"
model: claude-opus-4-7
---

Sprawdz umowe i zweryfikuj zgodnosc zobowiazan z aktualnym stanem realizacji dla klienta: **$ARGUMENTS**

## Krok 1: Znajdz umowe na Google Drive

Wyszukaj umowy uzywajac `search` z zapytaniami:
- "$ARGUMENTS umowa"
- "$ARGUMENTS kontrakt"
- "$ARGUMENTS oferta"
- "$ARGUMENTS zakres"
- "$ARGUMENTS scope"

Wybierz najbardziej aktualny dokument (umowa, oferta lub zakres wspolpracy). Jezeli jest kilka — wylistuj je i zapytaj uzytkownika ktory jest wlasciwy.

Jezeli nie znaleziono — przeszukaj strukture folderow przez `list_drives` → `list_folder` dla folderu klienta.

## Krok 2: Wyciagnij kluczowe zobowiazania

Z dokumentu umowy/oferty wyciagnij:

**Zakres prac** — co Whites zobowiazalo sie dostarczac (uslugi, deliverables, liczba materialow, itp.)

**Terminy** — kiedy co ma byc dostarczone (miesieczne, kwartalne, jednorazowe)

**Budzet / wycena** — ile i za co (jezeli dostepne)

**KPI / metryki sukcesu** — jezeli sa zdefiniowane w umowie

**Warunki specjalne** — co wymaga szczegolnej uwagi (np. akceptacje, SLA, raportowanie)

## Krok 3: Sprawdz aktualny stan realizacji

**Slack** — wyszukaj kanaly klienta (`slack_search_channels`). Dla kazdego kanalu uzyj `slack_read_channel` (limit: 200). Szukaj:
- Potwierdzenia dostarczen (np. "wyslano", "opublikowano", "zaakceptowane")
- Otwartych kwestii niezgodnych z umowa
- Prób zmiany zakresu ze strony klienta lub zespolu

**BlueDot** — wyszukaj spotkania (`search_meetings` z nazwa klienta). Szukaj:
- Ustalen dotyczacych zakresu lub zmian
- Potwierdzenia deliverables
- Niezgodnosci omówionych na spotkaniach

**Google Drive** — szukaj raportow, podsumowaniowych i materialow wskazujacych na realizacje zakresu

## Krok 4: Porownaj umowe z realizacja

Dla kazdego zobowiazania z umowy oceń:

| Zobowiazanie | Status | Dowod | Uwagi |
|--------------|--------|-------|-------|
| [z umowy] | ✅ Realizowane / ⚠️ Niezgodnosc / ❌ Brak realizacji / ❓ Brak danych | [skad wiadomo] | [ryzyko, zmiana zakresu] |

## Krok 5: Przedstaw podsumowanie

### Umowa: [Nazwa klienta]
**Dokument:** [nazwa + link]
**Zakres wspolpracy:** [krotkie podsumowanie]

### Zgodnosc z umowa: X%

### Realizowane zgodnie z umowa:
- [lista]

### Niezgodnosci lub ryzyka:
- [opis + skad wynika + rekomendacja]

### Brak danych:
- [co nie zostalo zweryfikowane i dlaczego]

### Rekomendacje dla PM-a:
- [co wymaga rozmowy z klientem, co wymaga korekty wewnetrznej]

## Krok 6: Akcja

Zapytaj:
"Co chcesz zrobic?
a) Zapisz podsumowanie do Google Doc
b) Wyslij notke do zespolu na Slack
c) Nic wiecej — dzieki"

## Zasady:
- Nie oceniaj jako "niezgodnosc" jezeli brak dowodow — uzywaj ❓
- Rozrozniaj miedzy zmiana zakresu zaakceptowana przez obie strony a niedostarczonymi elementami
- Nie szukaj winnych — celem jest identyfikacja ryzyk i luk, nie ocena pracy zespolu
- Jezeli umowy nie ma na Drive — poinformuj i zapytaj czy kontynuowac z dostepnymi materialami
