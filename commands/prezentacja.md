---
description: Wygeneruj profesjonalną prezentację Whites — od planu po gotowe slajdy
argument-hint: "[nazwa klienta] [typ: strategia|oferta|warsztaty|raport]"
model: claude-sonnet-4-6
---

Stwórz profesjonalną prezentację Whites dla: **$ARGUMENTS**

---

## ZASADY NIENARUSZALNE — czytaj przed każdym slajdem

**TEKST:**
- `bullets` / `challenges` / `recommendations`: max 8 słów na punkt — NIGDY pełne zdania
- `stat_big`: tylko liczba + etykieta max 10 słów — nic więcej, żadnych opisów
- `three_boxes` / `three_boxes_*`: max 3 zdania na box — nie więcej
- `analysis_numbered`: nagłówek 3–6 słów + opis max 3 zdania
- `long_description`: max 5 krótkich akapitów po max 3 zdania

**RÓŻNORODNOŚĆ:**
- Nie dawaj dwóch identycznych typów pod rząd — WYJĄTEK: `stat_big` w bloku statystyk, `analysis_numbered` w sekwencji analizy
- Każda sekcja >4 slajdów = min. 3 różne typy

**KOMPLETNOŚĆ:**
- Każdy slajd z planu musi być w pełni wypełniony — zero pustych pól
- Jeśli brak danych → w planie oznacz `[BRAK — uzupełnij]` i podaj klientowi listę

---

## FAZA 1: PLAN

### Krok 1 — zbierz dane równolegle

**Google Drive** (`search` z nazwą klienta):
- Umowa/oferta — zakres, budżet, cele, deliverables
- Strategia/brief — wyzwania klienta, cele biznesowe
- Poprzednie prezentacje — kontekst i elementy do zachowania

**Slack** (`slack_search_channels` + `slack_read_channel` limit: 100):
- Ustalenia co ma być w prezentacji
- Notatki ze spotkań, action items

**BlueDot** (`search_meetings` z nazwą klienta):
- Ostatnie spotkanie — co klient chciał zobaczyć
- Podjęte decyzje dotyczące prezentacji

**Gmail** (`search_threads` query: `[klient] newer_than:30d`, pageSize: 5):
- Briefing e-mailowy, wytyczne klienta

### Krok 2 — stwórz plan slajd po slajdzie

Napisz pełny plan prezentacji. Każdy slajd w formacie:

```
SLAJD [N] | [TYP]
[pełna treść — nagłówki, punkty, liczby, dokładnie to co trafi na slajd]
```

**Standard głębokości treści — KRYTYCZNE.** Każdy punkt musi być na tyle konkretny, że można go od razu wkleić na slajd. Zbyt ogólne sformułowanie = błąd planu.

| Niedopuszczalne | Wymagane |
|-----------------|----------|
| "Wyzwania klienta" | "Brak osoby wewnętrznej do nagrywania video co 2 tygodnie" |
| "Dane rynkowe" | "74% odbiorców preferuje autentyczne wideo — Sprout Social 2024" |
| "Strategia contentu" | "6 rolek produktowych, 1 dzień sesji, Miś jako narrator" |
| "Nasze podejście" | "Human-led, AI-powered: strategia → agenci → redakcja" |

**Pokaż plan i CZEKAJ na zatwierdzenie użytkownika ("ok" / "generuj" / "gotowe") przed Fazą 2.**

---

## FAZA 2: GENEROWANIE

Po zatwierdzeniu planu:

1. **Utwórz prezentację:**
   `create_presentation(title: "[KLIENT] — [TEMAT]", folder_id: "1NtVEVJ676zaU6EXvrq4lTJYiQg30qo3P")`
   — domyślny folder prezentacji Whites; zmień tylko jeśli Krystian poda inny wprost.

2. **Dodaj slajdy z planu** — dla każdego: `add_slide` → `replace_text` z zatwierdzonym tekstem (patrz sekcja techniczna poniżej)

3. **Sprawdź walidację** (lista na końcu skilla) przed `finalize_presentation()`

4. **Podaj link** do gotowej prezentacji.

---

## JAK DZIAŁA replace_text — ZASADY TECHNICZNE

`replace_text` to Google Slides `replaceAllText` — podmienia WSZYSTKIE wystąpienia szukanego tekstu w całej prezentacji.
**Zawsze podawaj `slide_id`** — inaczej trafisz w slajdy szablonowe, które jeszcze nie zostały usunięte.

### Agenda (slajd 2)
Szablon `agenda` ma JEDNO pole tekstowe na wszystkie pozycje agendowe. Wstaw wszystkie sekcje w jednym `replace_text` rozdzielone `\n`:

```
replace_text(
  find:     "Case Study",
  replace:  "01 Tytuł sekcji pierwszej\n02 Tytuł sekcji drugiej\n03 Tytuł sekcji trzeciej\n04 Tytuł sekcji czwartej",
  slide_id: [id slajdu agendy]
)
```

Jeśli szablon ma też placeholder "Co dziś przygotowaliśmy?" — podmień na "Agenda" lub krótki opis.

### Slajdy z wieloma itemami (bullets, recommendations, challenges)
Wszystkie itemy w JEDNYM replace_text rozdzielone `\n`:
```
replace_text(find: "Warto zdefiniować", replace: "Item 1\nItem 2\nItem 3\nItem 4", slide_id: ...)
```

### Slajdy section / section_subtitle
Placeholdery: `"PRZYKŁADOWA"` (tytuł) i `"przekladka z podtytułem"` (podtytuł).
Każdy section_subtitle musi być podmieniony OSOBNO ze swoim `slide_id` — inaczej zmienisz wszystkie naraz na ten sam tekst.

### Slajd kontaktowy (ostatni) — `contact_2`
Używaj wyłącznie `contact_2`. Zawiera adres Whites bez hardcoded zdjęcia konkretnej osoby.
**Zdjęcia NIE można podmienić przez `replace_text` — nie próbuj.**

### Slajd tytułowy (slajd 1)
Placeholder na podtytuł: `"Ścieżka pacjenta, lekarza i farmaceuty"` → podmień na temat prezentacji.

---

## MAPA TYPÓW SLAJDÓW

### Każda prezentacja zaczyna się tak (bez wyjątków):
| Slajd | Typ | Treść |
|-------|-----|-------|
| 1 | `title` | "Osiągamy ambitne cele z największymi firmami w Polsce i na świecie" + temat prezentacji jako podtytuł |
| 2 | `agenda` | Sekcje 01, 02, 03… (max 8) — jeden replace_text z `\n` na separator |
| 3–5 | `long_description` | 1 slajd = 1 osoba: imię jako tytuł, rola + bio 2–3 zdania jako treść |
| ostatni | `contact_2` | Whites Sp. z o.o., adres, kontakt — NIE podmieniaj zdjęcia |

---

### Rozdziały i przejścia

| Zawartość | Typ |
|-----------|-----|
| Tytuł nowej sekcji (1–4 słowa) | `section` |
| Tytuł + krótki podtytuł sekcji | `section_subtitle` |
| Tytuł z nadrzędną etykietą/numerem | `section_supertitle` |

---

### Dane i liczby — ZAWSZE stat_big dla liczb

| Zawartość | Typ |
|-----------|-----|
| Jeden duży wskaźnik (%, liczba, krotność) — np. "53%", "+9 mln", "2x" | `stat_big` |
| Wskaźnik w kontekście odbiorców/użytkowników | `stat_users` |
| Blok 3–5 metryk → kilka `stat_big` pod rząd | wiele `stat_big` |

**REGUŁA:** Każda liczba procentowa lub wskaźnik → własny `stat_big`. Nigdy nie wrzucaj liczby do bullets.

---

### Listy i punkty

| Zawartość | Typ |
|-----------|-----|
| Lista 3–8 krótkich punktów (jednorodne, bez kategorii) | `bullets` |
| Lista z pogrubionymi nagłówkami grup | `bullets_headers` |
| Lista problemów / wyzwań klienta | `challenges` |
| Lista działań / next steps / deliverables | `recommendations` |

---

### Analiza i strategia

| Zawartość | Typ |
|-----------|-----|
| 3–5 ponumerowanych analiz z nagłówkiem + opisem | `analysis_numbered` |
| Tabela: wyzwanie → diagnoza → rozwiązanie (lub podobna 3-kolumnowa) | `data_analysis_numbered` |
| Strategia z filarami / obszarami działań | `strategy` |

---

### Trzy równoległe elementy

| Zawartość | Typ |
|-----------|-----|
| 3 usługi / kanały / podejścia (równorzędne) | `three_boxes` |
| 3 elementy — jeden wyróżniony (np. polecany) | `three_boxes_highlight` |
| 3 elementy — wariant wizualny A | `three_boxes_alt_1` |
| 3 elementy — wariant wizualny B | `three_boxes_alt_2` |

**REGUŁA:** Każde 3 równoległe elementy → `three_boxes` (nie bullets!). Jeśli 4 elementy → `analysis_numbered` lub 2× `three_boxes`.

---

### Cytaty i insighty

| Zawartość | Typ |
|-----------|-----|
| Cytat klienta / eksperta / z raportu (1–2 zdania + źródło) | `quote` |
| 2–4 bloki z ikoną + krótki opis (benefit-driven) | `insight_blocks` |

---

### Tekst opisowy

| Zawartość | Typ |
|-----------|-----|
| Szczegółowe wyjaśnienie (max 5 akapitów) | `long_description` |
| Dwie kolumny tekstu z nagłówkami | `text_columns` |

---

### Wykresy i wizualizacje

| Zawartość | Typ |
|-----------|-----|
| Nagłówek zapowiadający sekcję z wykresami | `charts_header` |
| Wykres + tytuł + źródło | `chart_slide` |
| Nagłówek przed zdjęciami / case studies wizualnymi | `photos_header` |

---

### Grupy docelowe

| Zawartość | Typ |
|-----------|-----|
| Opis grupy docelowej z atrybutami | `target_group` |

---

## SZABLONY STRUKTURY WG TYPU PREZENTACJI

### Oferta (sprzedażowa)
```
title → agenda → team (long_description × N osób) → [sekcja: problem/wyzwania klienta: challenges] →
[sekcja: nasze podejście: strategy / three_boxes] →
[sekcja: zakres usług: analysis_numbered + bullets_headers] →
[sekcja: case studies: bullets_headers + stat_big] →
[sekcja: deliverables i harmonogram: recommendations + analysis_numbered] →
[sekcja: budżet: long_description lub bullets] →
contact_2
```

### Strategia
```
title → agenda → team (long_description × N osób) →
[sekcja: kontekst rynkowy / AI: stat_big × 3–5 + long_description] →
[sekcja: cele strategiczne: three_boxes lub strategy] →
[sekcja: analiza sytuacji wyjściowej: analysis_numbered + data_analysis_numbered] →
[sekcja: wyzwania: challenges] →
[sekcja: rekomendacje: analysis_numbered + recommendations] →
[sekcja: plan działania: strategy + recommendations] →
[sekcja: KPI: stat_big + bullets] →
contact_2
```

### Warsztaty / kick-off
```
title → agenda → team (long_description × N osób) →
[sekcja: kontekst / cel warsztatów: long_description] →
[blok tematyczny 1: section → bullets_headers → analysis_numbered] →
[blok tematyczny 2: section → bullets_headers → three_boxes] →
[...kolejne bloki...] →
[sekcja: wnioski / Q&A: summary + bullets] →
contact_2
```

### Raport / podsumowanie
```
title → agenda →
[sekcja: wyniki ogólne: stat_big × 3–5] →
[sekcja: analiza 1: section → chart_slide → analysis_numbered] →
[sekcja: analiza 2: section → chart_slide → bullets_headers] →
[...] →
[sekcja: wnioski: summary lub long_description] →
[sekcja: rekomendacje: recommendations + analysis_numbered] →
contact_2
```

---

## LIMITY TEKSTU PER TYP

| Typ | Tytuł/nagłówek | Treść |
|-----|----------------|-------|
| `title` | max 80 znaków | podtytuł max 80 znaków |
| `agenda` | "Agenda" | max 8 punktów × max 45 znaków, separator `\n` |
| `section` | max 45 znaków | — |
| `section_subtitle` | max 45 znaków | podtytuł max 70 znaków |
| `stat_big` | liczba max 10 znaków | etykieta max 70 znaków |
| `bullets` | max 65 znaków | 3–8 punktów × max 65 znaków, separator `\n` |
| `bullets_headers` | max 65 znaków | 2–4 grupy × 2–5 punktów × max 65 znaków |
| `three_boxes` | max 50 znaków/box | max 180 znaków/box |
| `three_boxes_highlight` | max 50 znaków/box | max 150 znaków/box |
| `analysis_numbered` | max 65 znaków | 3–5 elementów: nagłówek (45 zn) + opis (220 zn) |
| `data_analysis_numbered` | max 65 znaków | 3–5 wierszy z 2–3 kolumnami |
| `challenges` | max 65 znaków | 3–6 wyzwań × max 90 znaków, separator `\n` |
| `recommendations` | max 65 znaków | 3–6 rekomendacji × max 110 znaków, separator `\n` |
| `strategy` | max 65 znaków | 3–5 filarów z nazwami i opisami |
| `long_description` | max 65 znaków | max 5 akapitów × max 250 znaków |
| `text_columns` | max 65 znaków | 2 kolumny × max 300 znaków |
| `quote` | — | max 220 znaków + imię i rola autora |
| `insight_blocks` | max 65 znaków | 2–4 bloki: ikona + nagłówek (30 zn) + opis (100 zn) |
| `chart_slide` | max 65 znaków | tytuł wykresu + źródło |

---

## ZASADY MERYTORYCZNE

1. **Kompletność danych:** Jeśli klient ma 5 wyzwań — pokaż wszystkie 5, nie streszczaj do 3
2. **Liczby → stat_big:** Każda konkretna liczba procentowa, krotność lub wskaźnik = własny `stat_big`, nigdy w bullets
3. **Case studies:** Dla każdego: klient + czas współpracy + zakres + konkretny wynik (liczba)
4. **Kontekst AI/GEO:** Przy strategii SEO/GEO dodaj blok statystyk rynkowych z `stat_big` (ChatGPT, AI Overview, AI Mode) przed rekomendacjami — to jest standard Whites
5. **Źródła:** Przy każdym `stat_big` i `chart_slide` podaj źródło jeśli dostępne
6. **Język:** Dopasuj ToV do klienta — B2B/korporacja = formalny; start-up/agencja = bezpośredni
7. **Nie skracaj:** Jeśli plan zatwierdził 7 punktów analizy — wygeneruj 7, nie 4
8. **Żadnych generycznych fraz:** "innowacyjne podejście", "kompleksowa obsługa", "dynamiczny rozwój" — to nie są treści slajdów. Każdy punkt musi opisywać KONKRETNE działanie, wynik lub dane.

---

## WALIDACJA PRZED finalize_presentation()

Sprawdź każdy punkt przed finalizacją:

- [ ] Slajd 1 = `title` z nagłówkiem "Osiągamy ambitne cele..."
- [ ] Slajd 2 = `agenda` z ponumerowanymi sekcjami (wszystkie w jednym polu, `\n` jako separator)
- [ ] Slajdy 3–5 = `long_description` (1 osoba / 1 slajd)
- [ ] Ostatni slajd = `contact_2`
- [ ] Brak dwóch identycznych typów pod rząd (poza wyjątkami)
- [ ] Wszystkie pola każdego slajdu wypełnione — zero placeholderów z szablonu
- [ ] Limity znaków nie przekroczone
- [ ] Liczba slajdów zgodna z zatwierdzonym planem
- [ ] Każdy replace_text scoped do `slide_id`
- [ ] Żadnej generycznej treści — każdy punkt konkretny i oparty na danych

Jeśli cokolwiek nie jest spełnione — popraw **przed** `finalize_presentation()`.
