---
description: Podsumuj spotkanie i wyciągnij action items
argument-hint: "[nazwa klienta] lub [link BlueDot]"
model: claude-sonnet-4-6
---

Podsumuj ostatnie spotkanie z klientem: **$ARGUMENTS**

## Krok 1 — znajdź spotkanie

Jeśli `$ARGUMENTS` zawiera link BlueDot — użyj `mcp__bluedot__get_meeting` z ID z linku.

Jeśli podano nazwę klienta — użyj `mcp__bluedot__search_meetings` z nazwą klienta i wybierz najnowsze spotkanie. Poinformuj PM-a które spotkanie znalazłeś (tytuł + data) przed generowaniem podsumowania.

## Krok 2 — wyciągnij dane

Z transkrypcji i notatek wyciągnij:
- Główne tematy omawiane na spotkaniu
- Podjęte decyzje
- Action items (kto, co, do kiedy)
- Otwarte kwestie bez rozstrzygnięcia

## Krok 3 — wygeneruj podsumowanie

```
## PODSUMOWANIE SPOTKANIA
[Tytuł spotkania] · [Data] · [Uczestnicy]

### 📌 OMAWIANE TEMATY
- [temat 1]
- [temat 2]

### ✅ PODJĘTE DECYZJE
- [decyzja 1]
- [decyzja 2]

### 🎯 ACTION ITEMS
| Kto | Co | Do kiedy |
|-----|----|----------|
| [imię] | [zadanie] | [termin lub "ASAP"] |

### ❓ NIEROZSTRZYGNIĘTE KWESTIE
- [sprawa wymagająca dalszych ustaleń]

### 💬 CYTAT KLIENTA (jeśli istotny)
"[dosłowna wypowiedź klienta jeśli warta zapamiętania]"
```

## Krok 4 — zapytaj o wysyłkę

Po wygenerowaniu podsumowania zapytaj:
> Czy wysłać podsumowanie na Slack? Jeśli tak — podaj kanał lub osobę.

Jeśli PM potwierdzi — wyślij przez `mcp__claude_ai_Slack__slack_send_message` w formie czytelnej wiadomości (bez tabelki Markdown, Slack jej nie renderuje — użyj list i pogrubień).

## Zasady:
- Action items: zawsze z właścicielem — jeśli nieznany, napisz "do ustalenia"
- Jeśli brak transkrypcji — pracuj na notatkach BlueDot
- Działaj bez pytań do momentu wysyłki na Slack
