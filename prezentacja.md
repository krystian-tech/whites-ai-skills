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

Plan musi zawierać **dokładną treść** każdego slajdu — nie ogólniki, nie "tu wstaw coś o SEO". Jeśli masz dane — wstaw je. Jeśli brakuje — zaznacz `[BRAK]`.

**Pokaż plan i CZEKAJ na zatwierdzenie użytkownika ("ok" / "generuj" / "gotowe") przed Fazą 2.**

---

## FAZA 2: GENEROWANIE

Po zatwierdzeniu planu:

1. **Zapytaj o folder:**
   > Gdzie zapisać prezentację? Podaj nazwę lub link do folderu Google Drive.

2. **Utwórz prezentację:**
   `create_presentation(title: "[KLIENT] — [TEMAT]", folder_id: "[folder]")`

3. **Dodaj slajdy z planu** — dla każdego: `add_slide` → `replace_text` z zatwierdzonym tekstem

4. **Sprawdź walidację** (lista na końcu skilla) przed `finalize_presentation()`

5. **Podaj link** do gotowej prezentacji.

---

## MAPA TYPÓW SLAJDÓW

### Każda prezentacja zaczyna się tak (bez wyjątków):
| Slajd | Typ | Treść |
|-------|-----|-------|
| 1 | `title` | Nagłówek: "Osiągamy ambitne cele z największymi firmami w Polsce i na świecie" + konkretny temat prezentacji jako podtytuł |
| 2 | `agenda` | Sekcje ponumerowane 01, 02, 03… (max 8 punktów) |
| 3–5 | team | Imię, rola, bio 2–3 zdania — każda osoba osobno lub razem wg szablonu zespołu |
| ostatni | `contact` lub `contact_2` | Dane kontaktowe PM, adres, logo |

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
title → agenda → team → [sekcja: problem/wyzwania klienta: challenges] →
[sekcja: nasze podejście: strategy / three_boxes] →
[sekcja: zakres usług: analysis_numbered + bullets_headers] →
[sekcja: case studies: bullets_headers + stat_big] →
[sekcja: deliverables i harmonogram: recommendations + analysis_numbered] →
[sekcja: budżet: long_description lub bullets] →
contact
```

### Strategia
```
title → agenda → team →
[sekcja: kontekst rynkowy / AI: stat_big × 3–5 + long_description] →
[sekcja: cele strategiczne: three_boxes lub strategy] →
[sekcja: analiza sytuacji wyjściowej: analysis_numbered + data_analysis_numbered] →
[sekcja: wyzwania: challenges] →
[sekcja: rekomendacje: analysis_numbered + recommendations] →
[sekcja: plan działania: strategy + recommendations] →
[sekcja: KPI: stat_big + bullets] →
contact
```

### Warsztaty / kick-off
```
title → agenda → team →
[sekcja: kontekst / cel warsztatów: long_description] →
[blok tematyczny 1: section → bullets_headers → analysis_numbered] →
[blok tematyczny 2: section → bullets_headers → three_boxes] →
[...kolejne bloki...] →
[sekcja: wnioski / Q&A: summary + bullets] →
contact
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
contact
```

---

## LIMITY TEKSTU PER TYP

| Typ | Tytuł/nagłówek | Treść |
|-----|----------------|-------|
| `title` | max 80 znaków | podtytuł max 80 znaków |
| `agenda` | "Agenda" | max 8 punktów × max 45 znaków |
| `section` | max 45 znaków | — |
| `section_subtitle` | max 45 znaków | podtytuł max 70 znaków |
| `stat_big` | liczba max 10 znaków | etykieta max 70 znaków |
| `bullets` | max 65 znaków | 3–8 punktów × max 65 znaków |
| `bullets_headers` | max 65 znaków | 2–4 grupy × 2–5 punktów × max 65 znaków |
| `three_boxes` | max 50 znaków/box | max 180 znaków/box |
| `three_boxes_highlight` | max 50 znaków/box | max 150 znaków/box |
| `analysis_numbered` | max 65 znaków | 3–5 elementów: nagłówek (45 zn) + opis (220 zn) |
| `data_analysis_numbered` | max 65 znaków | 3–5 wierszy z 2–3 kolumnami |
| `challenges` | max 65 znaków | 3–6 wyzwań × max 90 znaków |
| `recommendations` | max 65 znaków | 3–6 rekomendacji × max 110 znaków |
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

---

## WALIDACJA PRZED finalize_presentation()

Sprawdź każdy punkt przed finalizacją:

- [ ] Slajd 1 = `title` z nagłówkiem "Osiągamy ambitne cele..."
- [ ] Slajd 2 = `agenda` z ponumerowanymi sekcjami
- [ ] Slajdy 3–5 zawierają team Whites
- [ ] Ostatni slajd = `contact` lub `contact_2`
- [ ] Brak dwóch identycznych typów pod rząd (poza wyjątkami)
- [ ] Wszystkie pola każdego slajdu wypełnione — zero pustych placeholderów
- [ ] Limity znaków nie przekroczone
- [ ] Liczba slajdów zgodna z zatwierdzonym planem

Jeśli cokolwiek nie jest spełnione — popraw **przed** `finalize_presentation()`.
