#!/usr/bin/env bash
# Under the default pane_borders = "auto" a lone pane has no border, so its ID
# title is invisible. config.toml belongs to the user, so nudge once instead of
# editing it.
set -u
herdr="${HERDR_BIN_PATH:-herdr}"
state="${HERDR_PLUGIN_STATE_DIR:-}"
[ -n "$state" ] && [ ! -e "$state/border-hint-shown" ] || exit 0

config="${HERDR_CONFIG_PATH:-$HOME/.config/herdr/config.toml}"
grep -Eq '^[[:space:]]*pane_borders[[:space:]]*=[[:space:]]*"always"' "$config" 2>/dev/null && exit 0

mkdir -p "$state"
"$herdr" notification show "Pane IDs are hidden on lone panes" \
  --body 'Set pane_borders = "always" under [ui] in config.toml to show them everywhere' \
  >/dev/null 2>&1 && : > "$state/border-hint-shown"
