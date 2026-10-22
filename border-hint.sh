#!/usr/bin/env bash
# Nudge rather than edit config.toml; it belongs to the user.
set -u
herdr="${HERDR_BIN_PATH:-herdr}"
marker="${HERDR_PLUGIN_STATE_DIR:?}/border-hint-shown"
[ -e "$marker" ] && exit 0
grep -Eq '^[[:space:]]*pane_borders[[:space:]]*=[[:space:]]*"always"' "$HOME/.config/herdr/config.toml" 2>/dev/null && exit 0

mkdir -p "${marker%/*}"
"$herdr" notification show "Pane IDs are hidden on lone panes" \
  --body 'Set pane_borders = "always" under [ui] in config.toml to show them everywhere' \
  >/dev/null 2>&1 && touch "$marker"
