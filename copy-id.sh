#!/usr/bin/env bash
# Copy the focused pane's ID to the system clipboard and show a toast.
set -u
herdr="${HERDR_BIN_PATH:-herdr}"
id="${HERDR_PANE_ID:-}"
[ -n "$id" ] || { echo "no focused pane" >&2; exit 1; }

if command -v pbcopy >/dev/null; then printf '%s' "$id" | pbcopy
elif command -v wl-copy >/dev/null; then printf '%s' "$id" | wl-copy
elif command -v xclip >/dev/null; then printf '%s' "$id" | xclip -selection clipboard
elif command -v xsel >/dev/null; then printf '%s' "$id" | xsel --clipboard --input
else echo "no clipboard tool found (pbcopy, wl-copy, xclip, xsel)" >&2; exit 1
fi
"$herdr" notification show "Copied pane ID" --body "$id" --sound none >/dev/null 2>&1 || true
