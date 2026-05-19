# whites-ai-skills

Skille Claude Code dla PM-ów Whites Agency. Instalacja jedną komendą, działają w każdej sesji Claude Code.

## Instalacja

```bash
curl -s https://raw.githubusercontent.com/krystian-tech/whites-ai-skills/main/install.sh | bash
```

---

## Skille

### `/daily`
Codzienny briefing PM-a — Slack Later, kalendarz, Gmail, taski specjalistów.
```
/daily
```

### `/reminder [klient]`
Przypomnienia do specjalistów o otwartych taskach dla klienta.
```
/reminder RS Components
```

### `/billing [klient] [okres]`
Rozliczenie projektu — zakres vs. dostarczone, z dowodem realizacji.
```
/billing RS Components maj 2026
```

### `/contract-check [klient]`
Weryfikacja zgodności zobowiązań z aktualnym stanem realizacji.
```
/contract-check RS Components
```

### `/report-check [klient]`
Sprawdzenie czy raport miesięczny jest gotowy i kompletny.
```
/report-check Polsat Plus
```

### `/strategy-check [klient]`
Weryfikacja realizacji strategii — czy robimy to co obiecaliśmy.
```
/strategy-check RS Components
```

### `/roadmapa [klient]`
Generuje roadmapę projektową w Google Sheets z taskami z Slacka, BlueDota i maila.
```
/roadmapa Stabill
```

### `/onepager [klient]`
Generuje HTML brief projektu i publikuje go na GitHub Pages.
```
/onepager RS Components
```
Wynikowy URL: `https://krystian-tech.github.io/whites-ai-skills/briefs/[nazwa-klienta].html`

Wszystkie briefy: `https://krystian-tech.github.io/whites-ai-skills/`

---

## Publikacja briefów (GitHub Pages)

Brief generowany przez `/onepager` trafia automatycznie na GitHub Pages po każdym uruchomieniu skilla.

**Pierwsze uruchomienie — jednorazowa konfiguracja GitHub Pages:**
1. Wejdź na https://github.com/krystian-tech/whites-ai-skills/settings/pages
2. **Source:** Deploy from a branch
3. **Branch:** `main` / folder: `/docs`
4. Kliknij **Save**
5. Po chwili strona będzie dostępna pod: `https://krystian-tech.github.io/whites-ai-skills/`

**Jak działa automatyczna publikacja:**
Skill `/onepager` po wygenerowaniu HTML robi `git push` do repozytorium.
GitHub Pages automatycznie serwuje wszystko z folderu `docs/`.
URL briefa: `https://krystian-tech.github.io/whites-ai-skills/briefs/[nazwa-klienta].html`

**Fallback — ręczne wklejenie w Google Sites:**
1. Otwórz wygenerowany plik w przeglądarce
2. Prawy klik → **Pokaż źródło strony**
3. Zaznacz wszystko (Cmd+A) → skopiuj (Cmd+C)
4. W Google Sites: **Wstaw → Osadź → Embed code** → wklej → OK

---

## Wymagania

- Claude Code z zainstalowanymi MCP: Slack, Google Drive, Gmail, Google Calendar, BlueDot
- Git skonfigurowany z dostępem do `github.com/krystian-tech/whites-ai-skills`
