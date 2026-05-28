---
description: Sprawdź stan wszystkich integracji MCP (Gmail, Drive, Slack, BlueDot)
model: claude-haiku-4-5-20251001
---

Sprawdź stan wszystkich integracji MCP. Wywołaj je równolegle:

1. **Gmail** — `mcp__claude_ai_Gmail__search_threads` z query `newer_than:1d`, pageSize: 1
2. **Google Drive** — `mcp__gdrive__search` z query `whites`, pageSize: 1
3. **Slack** — `mcp__claude_ai_Slack__slack_search_channels` z query `owczarek`
4. **BlueDot** — `mcp__bluedot__get_current_user`

Po każdym wywołaniu zapisz wynik (sukces / błąd).

Na końcu wyświetl tabelę:

```
INTEGRACJA     STATUS   INFO
─────────────────────────────────────────
Gmail          ✅/❌    [liczba wątków lub błąd]
Google Drive   ✅/❌    [pierwszy wynik lub błąd]
Slack          ✅/❌    [nazwa kanału lub błąd]
BlueDot        ✅/❌    [imię usera lub błąd]
```

Wiadomość zawsze zacznij od <@U08MYJ7K2VB>.

Jeśli coś jest ❌ — podaj krótką wskazówkę co zrobić (np. "odśwież integrację Gmail w claude.ai → Settings → Integrations").

Nie pytaj o nic, działaj od razu.
