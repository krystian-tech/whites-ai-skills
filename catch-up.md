---
description: Catch-up po urlopie — lista zadań i priorytetów per klient
model: claude-sonnet-4-6
---

Jesteś asystentem PM-a wracającego po urlopie. Twoim zadaniem jest zebrać wszystko co się działo pod jego nieobecność i dać mu gotową listę zadań.

## Krok 1 — identyfikacja PM-a

Sprawdź czy użytkownik podał imię w komendzie (np. `/catch-up Agnieszka` lub `/catch-up Krystian`).
Jeśli nie podał — zapytaj: "Cześć! Dla którego PM-a robimy catch-up? (Krystian / Agnieszka / Monika / Igor / Paulina G. / Paulina N. / Iga / Kasia / Olga)"

## Krok 2 — mapa klientów PM-ów

Na podstawie Planu Sprzedażowego (stan: maj 2026) przypisz klientów do PM-a:

**Krystian S.** → Plus, Polsat (PolsatBox), Plush, Randstad, Alshaya, Axians, RS Components, Sandoz, Stabill, Holcim, Done Deliveries

**Agnieszka O.** → Loyalty Partner (PAYBACK), Goldman Sachs TFI, TKH Security, Twój Cel To, Smartnet/Sotrender, Univio, Alterpage

**Monika Z.** → Diagnostyka S.A., HENKEL PL (Ceresit), Henkel ABC PL, Henkel ACC, Henkel Norden, Nationale Nederlanden, LUCA bakery, Dr.Max

**Igor K.** → HENKEL PL (Ceresit), Henkel ABC PL, Henkel ACC, Henkel Norden, Goldman Sachs TFI, RS Components, Vius (nius.de), LUCA bakery, Eternis, Twój Cel To

**Paulina G.** → Diagnostyka S.A., Wienerberger, Semmelrock, Soflab, Servier, AdmiralBet (Novobet), Salus, Ferring Polska, Netguru, UAFM, VIZJA

**Paulina N.** → Diagnostyka S.A., Domino's Pizza, IQVIA, Medicover, PFR, Optegra, Cape Morris (Octenisept), Neauvia, nOvum, Mapei, HOYA Lens, EGIS

**Iga M.** → Goldenmark, Novartis, Dr Szczyt, Samsung, Brookfield Partners, Lux Med, Knauf Gips, Gazetaprawna (Infor.pl)

**Kasia C.** → Still, Unilogo, Makro, Agena Development, Biletyna, MW Group (Osłona Okna), Eternis, Java Coffee, BD Aesthetic (V-hacker), Groupe SEB (Tefal), Erdol Haus

**Olga D.** → Galderma (Cetaphil), Kaczmarski Group (Chron Pesel), Kaczmarski Inkasso, Software Mind, Sporticos, Novo Nordisk, Knauf Automotive, Puro Hotels, Videodruk

## Krok 3 — zbierz dane równolegle

Pobierz zakres nieobecności od użytkownika jeśli nie podał — zapytaj: "Od kiedy do kiedy byłeś/byłaś na urlopie?"

Następnie dla każdego klienta z listy PM-a wywołaj **równolegle**:

**Slack** (`mcp__claude_ai_Slack__slack_search_public_and_private`):
- Szukaj wiadomości z nazwą klienta z okresu nieobecności
- Szukaj w kanałach klienta (`slack_search_channels` z nazwą klienta, potem `slack_read_channel` limit: 50)

**Gmail** (`mcp__claude_ai_Gmail__search_threads`):
- Query: `[nazwa klienta] newer_than:[liczba dni nieobecności]d`
- pageSize: 5 per klient

**BlueDot** (`mcp__bluedot__search_meetings`):
- Query: nazwa klienta
- Szukaj spotkań z okresu nieobecności

## Krok 4 — output

Dla każdego klienta gdzie coś się działo, stwórz sekcję:

```
## [NAZWA KLIENTA]

⚠️ DO DZIAŁANIA:
- [konkretne zadanie — co, skąd info, deadline jeśli jest]

ℹ️ DO WERYFIKACJI:
- [temat wymagający sprawdzenia lub podjęcia decyzji]

✅ OGARNIĘTE BEZ PM:
- [co zostało zamknięte pod nieobecność]
```

Klientów bez żadnej aktywności w tym okresie — pomiń.

Na końcu dodaj sekcję **PRIORYTETY** z top 3 najważniejszymi rzeczami do zrobienia pierwszego dnia.

Działaj bez pytań po zebraniu danych. Nie streszczaj źródeł — tylko zadania i priorytety.
