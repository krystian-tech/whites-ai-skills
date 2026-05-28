---
description: Znajdź szanse na rozszerzenie zakresu u klienta
argument-hint: "[nazwa klienta]"
model: claude-sonnet-4-6
---

Znajdź szanse na rozszerzenie zakresu dla klienta: **$ARGUMENTS**

## Krok 1 — zbierz dane równolegle

**Google Drive** (`search` z nazwą klienta):
- Umowa/oferta — aktualny zakres i budżet
- Strategia klienta — cele i obszary które chce rozwijać
- Raporty — wyniki, co działa, co nie

**Slack** (`slack_search_channels` + `slack_read_channel` limit: 100):
- Prośby klienta które wychodzą poza zakres
- Tematy które klient sam porusza (nowe kanały, potrzeby, problemy)
- Komentarze zespołu o brakach w projekcie

**BlueDot** (`search_meetings` z nazwą klienta):
- Co klient mówił na spotkaniach o planach i kierunkach
- Tematy poza zakresem które się pojawiały

**Gmail** (`search_threads` query: `[nazwa klienta] newer_than:90d`, pageSize: 5):
- Pytania klienta o usługi spoza zakresu
- Sygnały o nowych potrzebach lub problemach

## Krok 2 — wygeneruj propozycje upsellowe

Przedstaw wynik w strukturze:

---

### 🎯 SZANSE UPSELLOWE
*(posortowane od najprawdopodobniejszej)*

Dla każdej szansy:

**[NAZWA USŁUGI/OBSZARU]** — [wysoki/średni priorytet]
- **Dlaczego teraz:** [konkretny sygnał ze źródeł — cytat, sytuacja, trend]
- **Co proponujemy:** [krótki opis usługi]
- **Argument dla klienta:** [jak to rozwiązuje jego problem lub realizuje cel]
- **Szacunkowy zakres:** [orientacyjnie — np. "2-3 artykuły/mies." lub "jednorazowy audit"]

---

### ⚠️ RYZYKA I KIEDY NIE PROPONOWAĆ
- [np. klient właśnie zgłosił problem z obecnym zakresem — zły moment]
- [np. budżet klienta był dyskutowany jako napięty]

---

### 💬 SUGEROWANY SPOSÓB OTWARCIA ROZMOWY
Krótki szkic jak naturalnie wprowadzić temat rozszerzenia na najbliższym statusie — bez wrażenia "sprzedawania".

---

## Zasady:
- Tylko szanse poparte konkretnymi sygnałami ze źródeł — nie wymyślaj
- Jeśli brak sygnałów dla jakiegoś obszaru — nie wpisuj go
- Maksymalnie 4 propozycje — lepiej mniej i konkretnie niż lista życzeń
- Działaj bez pytań, od razu po zebraniu danych
