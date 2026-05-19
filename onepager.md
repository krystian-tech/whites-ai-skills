---
description: Wygeneruj HTML brief projektu klienta i opublikuj na GitHub Pages
argument-hint: "[nazwa-klienta]"
model: claude-opus-4-7
---

Wygeneruj one-pager projektowy dla klienta: **$ARGUMENTS**

Repo lokalne: `$HOME/Documents/GitHub/whites-ai-skills/`
GitHub Pages URL bazy: `https://krystian-tech.github.io/whites-ai-skills/briefs/`

---

## Krok 1: Zbierz dane równolegle ze wszystkich źródeł

Uruchom jednocześnie:

### 1a. Slack — znajdź kanały klienta
Użyj `slack_search_channels` z nazwą klienta (próbuj wariantów).
Dla każdego kanału użyj `slack_read_channel` (limit: 100). Szukaj:
- Scope/zakres prac (co robimy, ile, jak często)
- Notatki ze spotkań (statusy, ustalenia)
- Otwarte sprawy, problemy, blokery
- Skład zespołu

### 1b. Google Drive — znajdź umowę i tracker
Użyj `search` z zapytaniami: `"$ARGUMENTS umowa"`, `"$ARGUMENTS tracker"`, `"$ARGUMENTS zakres"`.
Z umowy wyciągnij: zakres, budżet, okres trwania, deliverables.
Z trackera wyciągnij: procesy, statusy, zaległości.

### 1c. BlueDot — notatki ze spotkań
Użyj `search_meetings` z nazwą klienta. Wyciągnij action items i ustalenia.

### 1d. Gmail — korespondencja
Użyj `search_threads` z nazwą klienta (limit: 10 najnowszych). Szukaj ustaleń zakresu i problemów.

---

## Krok 2: Skompiluj dane w strukturę

Zbierz w logiczne sekcje:
- **Informacje ogólne:** budżet, data umowy, czas trwania, PM
- **Zakres prac:** procesy/obszary, co dokładnie robimy, normy miesięczne
- **Zespół Whites:** role i osoby
- **Kontakty klienta:** imię, rola, email
- **Otwarte sprawy:** podziel na ⚠️ (do działania) / ℹ️ (informacyjne) / ✅ (gotowe)
- **Kluczowe zasoby:** linki do trackera, CMS, Drive

Jeśli brakuje danych z jakiegoś źródła — pomiń sekcję lub oznacz jako "brak danych".

---

## Krok 3: Wygeneruj HTML

Użyj poniższego szablonu HTML. Wypełnij go danymi z kroku 2.
Nazwa pliku: `[nazwa-klienta-lowercase-bez-spacji].html` (np. `rs-components.html`, `polsat-plus.html`)

```html
<!DOCTYPE html>
<html lang="pl">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>[NAZWA KLIENTA] — Brief Projektu</title>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Segoe UI', Arial, sans-serif; background: #f4f5f7; color: #2c2c2c; padding: 32px 16px; }
    .container { max-width: 860px; margin: 0 auto; }
    .header { background: #1a1a2e; border-radius: 12px; padding: 28px 32px; margin-bottom: 24px; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 12px; }
    .header-left h1 { color: #fff; font-size: 22px; font-weight: 700; }
    .header-left p { color: #a0a8c0; font-size: 13px; margin-top: 4px; }
    .header-right { display: flex; flex-direction: column; align-items: flex-end; gap: 6px; }
    .badge { background: #e53935; color: #fff; font-size: 12px; font-weight: 600; padding: 4px 12px; border-radius: 20px; }
    .budget { color: #fff; font-size: 20px; font-weight: 700; }
    .budget span { font-size: 13px; color: #a0a8c0; font-weight: 400; }
    .section { background: #fff; border-radius: 10px; padding: 22px 24px; margin-bottom: 16px; box-shadow: 0 1px 4px rgba(0,0,0,0.07); }
    .section-title { font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; color: #888; margin-bottom: 16px; }
    .process-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(240px, 1fr)); gap: 14px; }
    .process-card { border-radius: 8px; padding: 16px; border-left: 4px solid; }
    .process-card h3 { font-size: 13px; font-weight: 700; margin-bottom: 4px; }
    .process-card .subtitle { font-size: 11px; color: #888; margin-bottom: 10px; }
    .process-card ul { padding-left: 16px; font-size: 13px; line-height: 1.7; color: #444; }
    .process-card .norm { margin-top: 10px; font-size: 12px; font-weight: 600; color: #555; background: rgba(0,0,0,0.05); display: inline-block; padding: 3px 8px; border-radius: 4px; }
    .color-1 { background: #eef4ff; border-color: #3b82f6; }
    .color-2 { background: #f0fdf4; border-color: #22c55e; }
    .color-3 { background: #fff7ed; border-color: #f97316; }
    .color-4 { background: #fdf4ff; border-color: #a855f7; }
    .team-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(180px, 1fr)); gap: 12px; }
    .team-card { background: #f8f9fb; border-radius: 8px; padding: 12px 14px; }
    .team-card .role { font-size: 10px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.8px; color: #aaa; margin-bottom: 4px; }
    .team-card .name { font-size: 14px; font-weight: 600; color: #1a1a2e; }
    .team-card .side { font-size: 11px; color: #888; margin-top: 2px; }
    .contact-row { display: flex; align-items: flex-start; gap: 12px; padding: 10px 0; border-bottom: 1px solid #f0f0f0; }
    .contact-row:last-child { border-bottom: none; }
    .contact-avatar { width: 36px; height: 36px; background: #1a1a2e; color: #fff; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 13px; font-weight: 700; flex-shrink: 0; }
    .contact-info .cname { font-size: 13px; font-weight: 600; }
    .contact-info .crole { font-size: 12px; color: #888; }
    .contact-info .cemail { font-size: 11px; color: #3b82f6; margin-top: 2px; }
    .alerts { display: flex; flex-direction: column; gap: 8px; }
    .alert { display: flex; align-items: flex-start; gap: 10px; padding: 10px 14px; border-radius: 7px; font-size: 13px; }
    .alert.warn { background: #fff8e1; color: #7a5c00; }
    .alert.info { background: #e8f4fd; color: #1565c0; }
    .alert.ok { background: #f0fdf4; color: #166534; }
    .alert .icon { font-size: 15px; flex-shrink: 0; margin-top: 1px; }
    .links-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 10px; }
    .link-item { display: flex; align-items: center; gap: 10px; background: #f8f9fb; border-radius: 7px; padding: 10px 12px; text-decoration: none; color: inherit; }
    .link-item:hover { background: #eef4ff; }
    .link-icon { width: 28px; height: 28px; border-radius: 6px; background: #1a1a2e; color: #fff; font-size: 13px; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
    .link-label { font-size: 13px; font-weight: 600; }
    .link-desc { font-size: 11px; color: #888; }
    .meta-row { display: flex; flex-wrap: wrap; gap: 20px; }
    .meta-item .label { color: #888; font-size: 11px; text-transform: uppercase; letter-spacing: 0.5px; }
    .meta-item .value { font-weight: 600; margin-top: 2px; font-size: 13px; }
    .footer { text-align: center; font-size: 11px; color: #bbb; margin-top: 24px; }
  </style>
</head>
<body>
<div class="container">

  <!-- HEADER: wypełnij nazwę klienta, budżet -->
  <div class="header">
    <div class="header-left">
      <h1>[NAZWA KLIENTA]</h1>
      <p>[TYP USŁUG] — Brief Projektu</p>
    </div>
    <div class="header-right">
      <span class="badge">ONGOING</span>
      <div class="budget">[BUDŻET] <span>netto/mies.</span></div>
    </div>
  </div>

  <!-- META -->
  <div class="section">
    <div class="section-title">Informacje ogólne</div>
    <div class="meta-row">
      <!-- przykład: <div class="meta-item"><div class="label">Umowa od</div><div class="value">14 lipca 2025</div></div> -->
      [META ITEMS]
    </div>
  </div>

  <!-- PROCESY: dodaj tyle kart ile procesów, użyj klas color-1, color-2, color-3, color-4 -->
  <div class="section">
    <div class="section-title">Zakres prac</div>
    <div class="process-grid">
      [PROCESS CARDS]
    </div>
  </div>

  <!-- ZESPÓŁ -->
  <div class="section">
    <div class="section-title">Zespół</div>
    <div class="team-grid">
      [TEAM CARDS]
    </div>
  </div>

  <!-- KONTAKTY KLIENTA -->
  <div class="section">
    <div class="section-title">Kontakty klienta</div>
    [CONTACT ROWS]
  </div>

  <!-- OTWARTE SPRAWY -->
  <div class="section">
    <div class="section-title">Otwarte sprawy</div>
    <div class="alerts">
      [ALERTS]
    </div>
  </div>

  <!-- ZASOBY — pomiń sekcję jeśli brak linków -->
  <div class="section">
    <div class="section-title">Kluczowe zasoby</div>
    <div class="links-grid">
      [LINK ITEMS]
    </div>
  </div>

  <div class="footer">Ostatnia aktualizacja: [MIESIAC ROK] · Whites Agency</div>

</div>
</body>
</html>
```

---

## Krok 4: Zapisz plik

Zapisz wygenerowany HTML do:
`$HOME/Documents/GitHub/whites-ai-skills/docs/briefs/[nazwa-klienta].html`

---

## Krok 5: Zaktualizuj index.html

Odczytaj `$HOME/Documents/GitHub/whites-ai-skills/docs/index.html`.
Dodaj nowy brief do listy projektów (sekcja `<ul id="briefs-list">`):
```html
<li><a href="briefs/[nazwa-klienta].html">[NAZWA KLIENTA]</a> — [TYP USŁUG] · aktualizacja: [MIESIAC ROK]</li>
```
Zapisz plik.

---

## Krok 6: Opublikuj na GitHub Pages

Wykonaj sekwencyjnie:

```bash
[ ! -d "$HOME/Documents/GitHub/whites-ai-skills" ] && git clone git@github.com:krystian-tech/whites-ai-skills.git "$HOME/Documents/GitHub/whites-ai-skills"
cd "$HOME/Documents/GitHub/whites-ai-skills"
git add docs/briefs/[nazwa-klienta].html docs/index.html
git commit -m "onepager: dodaj brief [NAZWA KLIENTA]"
git push origin main
```

Po pushu podaj użytkownikowi URL:
`https://krystian-tech.github.io/whites-ai-skills/briefs/[nazwa-klienta].html`

Poinformuj że GitHub Pages może potrzebować 1-2 minut na odświeżenie po pierwszym pushu.

---

## Krok 7: Fallback — Google Sites

Jeśli push się nie powiedzie LUB użytkownik poprosi o instrukcję dla Google Sites, wyświetl:

> **Jak wrzucić na Google Sites:**
> 1. Otwórz stronę w przeglądarce: `open [ścieżka do pliku]`
> 2. Prawy klik → **Pokaż źródło strony** → zaznacz wszystko (Cmd+A) → kopiuj (Cmd+C)
> 3. W Google Sites: **Wstaw → Osadź → Embed code** → wklej → OK

---

## Zasady:

- Jeśli nie znajdziesz danych z jakiegoś źródła — pomiń sekcję, nie zmyślaj
- Otwarte sprawy: tylko to co faktycznie wisi, nie teorie
- Kontakty klienta: tylko osoby po stronie klienta, nie Whites
- Budżet: jeśli nieznany — wpisz "do ustalenia"
- Nie pytaj o potwierdzenie przed generowaniem — działaj i pokaż gotowy wynik
- Jeśli klient ma mało danych (< 3 źródeł) — poinformuj i zapytaj czy kontynuować
