---
description: Weryfikacja raportow dla klienta — aktualnosc, kompletnosc, terminowosc
argument-hint: "[nazwa-klienta]"
model: claude-opus-4-7
---

Sprawdz stan raportow dla klienta: **$ARGUMENTS**

## Krok 1: Znajdz raporty na Google Drive

Wyszukaj raporty przez `search`:
- "$ARGUMENTS raport"
- "$ARGUMENTS report"
- "$ARGUMENTS podsumowanie"
- "$ARGUMENTS wyniki"

Posortuj wyniki chronologicznie — skup sie na najnowszych dokumentach.

Jezeli nie znaleziono — przeszukaj strukture przez `list_drives` → `list_folder` dla folderu klienta.

## Krok 2: Sprawdz harmonogram raportowania

Wyszukaj umowe lub zakres wspolpracy (`search` z "$ARGUMENTS umowa" / "zakres") aby ustalic:
- Jak czesto maja byc dostarczane raporty (miesiecznie, kwartalnie, po kampaniach)
- Co powinno byc w raporcie (KPI, metryki, podsumowanie dzialan)
- Komu jest dostarczany (klient, wewnetrznie)

Jezeli harmonogram nie jest w umowie — sprawdz Slack przez `slack_search_channels` i `slack_read_channel` pod katem ustalen dotyczacych raportowania.

## Krok 3: Zweryfikuj kazdy raport

Dla kazdego znalezionego raportu sprawdz:

**Aktualnosc** — kiedy zostal stworzony? Czy jest z biezacego okresu?

**Kompletnosc** — czy zawiera to co bylo ustalone (KPI, metryki, podsumowanie dzialan)?

**Terminowosc** — czy zostal dostarczony w ustalonym terminie?

**Wyslanie do klienta** — sprawdz Slack (`slack_search_channels`, `slack_read_channel`) czy raport zostal wyslany/udostepniony klientowi

## Krok 4: Sprawdz czy brakuje raportow

Na podstawie harmonogramu i daty ostatniego raportu ustal:
- Czy sa zaleglosci (np. raport za kwiecien nie istnieje)?
- Czy zbliza sie termin kolejnego raportu?

## Krok 5: Przedstaw podsumowanie

### Raporty: [Nazwa klienta]
**Harmonogram:** [ustalona czestotliwosc lub "brak ustalen"]

### Stan raportow:

| Okres | Raport istnieje? | Kompletny? | Wyslany do klienta? | Uwagi |
|-------|-----------------|------------|---------------------|-------|
| [np. Kwiecien 2026] | ✅ / ❌ | ✅ / ⚠️ / ❓ | ✅ / ❌ / ❓ | [link lub brak] |

### Zaleglosci:
- [lista brakujacych raportow jezeli sa]

### Zbliajace sie terminy:
- [co trzeba przygotowac w najblizszych tygodniach]

### Rekomendacje:
- [co wymaga pilnej akcji PM-a]

## Krok 6: Akcja

Zapytaj:
"Co chcesz zrobic?
a) Wyslij przypomnienie do specjalisty odpowiedzialnego za raport
b) Zapisz status do Google Doc
c) Nic wiecej — dzieki"

Jezeli opcja (a):
- Zapytaj kto jest odpowiedzialny za raportowanie dla tego klienta
- Wygeneruj draft wiadomosci Slack i wyslij po potwierdzeniu

## Zasady:
- Nie oceniaj jakosci raportow — tylko ich istnienie, kompletnosc i terminowosc
- Jezeli harmonogram jest nieznany — zaznacz to i dzialaj na podstawie tego co jest dostepne
- Sprawdzaj raporty z ostatnich 3 miesiecy — starsze pomijaj jezeli nie ma innego powodu
- Jezeli raport istnieje ale nie zostal wyslany — to osobne ryzyko, zaznacz je wyraznie
