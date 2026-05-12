#!/bin/bash

REPO="https://raw.githubusercontent.com/krystian-tech/whites-ai-skills/main"
DEST="$HOME/.claude/commands"
SKILLS=(
  "billing.md"
  "contract-check.md"
  "daily.md"
  "reminder.md"
  "report-check.md"
  "roadmapa.md"
  "strategy-check.md"
)

mkdir -p "$DEST"

echo "Instalowanie skilli Whites AI..."

for skill in "${SKILLS[@]}"; do
  curl -sL "$REPO/$skill" -o "$DEST/$skill"
  echo "  ✓ $skill"
done

echo ""
echo "Gotowe! Zrestartuj Claude Code żeby skille były aktywne."
echo "Dostępne komendy: /billing /contract-check /daily /reminder /report-check /roadmapa /strategy-check"
