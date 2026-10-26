#!/bin/bash
# Installe dev-browser et lance le Chromium préinstallé avec un port de debug,
# uniquement dans les sessions cloud Claude Code (conteneur éphémère).
set -uo pipefail
[ "${CLAUDE_CODE_REMOTE:-}" = "true" ] || exit 0

command -v dev-browser >/dev/null || npm install -g dev-browser >/dev/null 2>&1
[ -f "$HOME/.dev-browser/daemon.mjs" ] || dev-browser install >/dev/null 2>&1

# dev-browser veut télécharger son propre Chromium (bloqué par le proxy) :
# on lui fournit celui de /opt/pw-browsers via --connect.
if ! curl -s localhost:9222/json/version >/dev/null; then
  CHROME=$(ls -d /opt/pw-browsers/chromium-*/chrome-linux*/chrome 2>/dev/null | sort -V | tail -1)
  nohup "$CHROME" --headless=new --no-sandbox --remote-debugging-port=9222 \
    --user-data-dir="$HOME/.dev-browser/chrome-profile" about:blank >/dev/null 2>&1 &
  for _ in $(seq 20); do curl -s localhost:9222/json/version >/dev/null && break; sleep 0.5; done
fi

echo "dev-browser prêt : utiliser 'dev-browser --connect http://localhost:9222'. Captures en chemin relatif -> ~/.dev-browser/tmp/"
exit 0
