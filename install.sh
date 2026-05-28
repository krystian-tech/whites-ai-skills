#!/bin/bash

REPO="krystian-tech/whites-ai-skills"
RAW="https://raw.githubusercontent.com/$REPO/main"
DEST="$HOME/.claude/commands"

mkdir -p "$DEST"

echo "Instalowanie skilli Whites AI..."

# Pobierz dynamicznie listę .md z rootu repo (pomijaj README.md)
FILES=$(curl -s "https://api.github.com/repos/$REPO/contents" \
  | python3 -c "
import sys, json
files = json.load(sys.stdin)
for f in files:
    if f['type'] == 'file' and f['name'].endswith('.md') and f['name'] != 'README.md':
        print(f['name'])
")

if [ -z "$FILES" ]; then
  echo "❌ Nie udało się pobrać listy skilli z GitHub. Sprawdź połączenie."
  exit 1
fi

for skill in $FILES; do
  curl -sL "$RAW/$skill" -o "$DEST/$skill"
  echo "  ✓ $skill"
done

echo ""
echo "Gotowe! Zrestartuj Claude Code żeby skille były aktywne."
