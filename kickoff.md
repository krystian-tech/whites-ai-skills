---
description: Przygotuj kickoff z nowym klientem — agenda, pytania, brief dla zespołu
argument-hint: "[nazwa klienta]"
model: claude-sonnet-4-6
---

Przygotuj kickoff z nowym klientem: **$ARGUMENTS**

## Krok 1 — zbierz dane równolegle

**Google Drive** (`search` z nazwą klienta):
- Znajdź umowę lub ofertę — wyciągnij zakres, budżet, cele, deliverables
- Sprawdź czy są jakieś materiały od klienta (brief, strategia, materiały brandowe)

**Slack** (`slack_search_channels` z nazwą klienta):
- Sprawdź czy kanał klienta już istnieje i czy jest jakaś historia
- Wyciągnij kontekst jeśli były wcześniej rozmowy

**Gmail** (`search_threads` query: `[nazwa klienta] newer_than:30d`, pageSize: 5):
- Korespondencja poprzedzająca podpisanie umowy
- Ustalenia, oczekiwania, specyficzne prośby klienta

## Krok 2 — wygeneruj materiały kickoffowe

Przedstaw wynik w czterech sekcjach:

---

### 📋 AGENDA KICKOFFU
*(gotowa do wysłania klientowi)*

1. Przedstawienie zespołu Whites
2. Omówienie zakresu i celów projektu
3. Ustalenie rytmu pracy i komunikacji
4. Omówienie harmonogramu i kamieni milowych
5. Q&A

---

### ❓ PYTANIA DO KLIENTA
*(rzeczy które musisz wyjaśnić przed startem)*

**Zakres i cele:**
- [pytania wynikające z braków w umowie/ofercie]

**Zasoby i dostępy:**
- [np. dostęp do CMS, GA, social media, materiały brandowe]

**Komunikacja:**
- [kto jest głównym kontaktem, preferowany kanał, częstotliwość raportowania]

**Oczekiwania:**
- [KPI sukcesu, priorytety, rzeczy których klient chce unikać]

---

### 👥 BRIEF DLA ZESPOŁU WHITES
*(co każdy powinien wiedzieć przed kickoffem)*

**Klient:** [nazwa, branża, co robi]
**Zakres:** [co robimy]
**Budżet:** [jeśli dostępny]
**Główny kontakt:** [imię, rola]
**Cele projektu:** [top 3]
**Na co uważać:** [specyfika klienta, wrażliwe tematy, oczekiwania]

---

### ✅ CHECKLIST PRZED KICKOFFEM
- [ ] Kanał Slack klienta założony i zespół dodany
- [ ] Tracker projektowy utworzony
- [ ] Folder na Drive założony i udostępniony
- [ ] Dostępy od klienta zebrane (CMS, GA, social)
- [ ] Kalendarz statusów wpisany
- [ ] Umowa podpisana przez obie strony

---

## Zasady:
- Pytania do klienta: tylko te których naprawdę nie wiesz z dostępnych dokumentów
- Brief dla zespołu: zwięzły, max 10 linii — to nie pełna strategia
- Działaj bez pytań, od razu po zebraniu danych
