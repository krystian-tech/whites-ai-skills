---
description: Przygotuj briefing przed statusem z klientem
argument-hint: "[nazwa klienta]"
model: claude-sonnet-4-6
---

Przygotuj PM-a do statusu z klientem: **$ARGUMENTS**

## Krok 1 — zbierz dane równolegle

Uruchom jednocześnie:

**Slack** (`slack_search_channels` z nazwą klienta, potem `slack_read_channel` limit: 100):
- Co zostało dostarczone od ostatniego statusu
- Co jest w trakcie
- Blokery, problemy, eskalacje
- Pytania od klienta bez odpowiedzi

**BlueDot** (`search_meetings` z nazwą klienta):
- Znajdź ostatnie spotkanie z klientem
- Wyciągnij action items i ustalenia z poprzedniego statusu
- Sprawdź czy action items zostały zrealizowane

**Gmail** (`search_threads` query: `[nazwa klienta] newer_than:14d`, pageSize: 5):
- Otwarte wątki bez odpowiedzi
- Ustalenia i potwierdzenia z maili
- Sprawy zgłoszone przez klienta

**Google Drive** (`search` query: `[nazwa klienta]`):
- Najnowsze dokumenty, raporty, materiały
- Sprawdź czy są zaległe deliverables

## Krok 2 — wygeneruj briefing

Przedstaw wynik w strukturze:

```
## STATUS PREP — [NAZWA KLIENTA]
Data: [dzisiejsza data]

### ✅ DOSTARCZONE OD OSTATNIEGO STATUSU
- [co zostało zrobione, z jakiego źródła]

### 🔄 W TRAKCIE
- [co jest w realizacji, kto odpowiada, kiedy gotowe]

### ⚠️ BLOKERY I OTWARTE SPRAWY
- [co wymaga decyzji lub działania]

### ❓ PYTANIA OD KLIENTA BEZ ODPOWIEDZI
- [otwarte pytania z maili/Slacka]

### 📋 PROPONOWANA AGENDA
1. [punkt 1 — max 5 punktów]
2. [punkt 2]
...

### 💡 NA CO ZWRÓCIĆ UWAGĘ
- [ważne konteksty, ryzyka, rzeczy do poruszenia]
```

## Zasady:
- Tylko fakty ze źródeł — nie wymyślaj
- Agenda: max 5 punktów, konkretne tematy
- Blokery i pytania klienta zawsze na pierwszym miejscu uwagi PM-a
- Działaj bez pytań, od razu po zebraniu danych
