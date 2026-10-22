#!/usr/bin/env bash
# Give every pane a display title "[<agent> - ]<pane-id>[ · <pane name>]", e.g.
#   claude - w2H:p1
#   w2H:p4
#   claude - w3R:p6 · api-tests
# The title is Herdr pane metadata, so the user's own pane name is never
# modified. Panes whose title is already correct are skipped.
set -u
herdr="${HERDR_BIN_PATH:-herdr}"

"$herdr" pane list 2>/dev/null \
  | jq -r '.result.panes[]
           | [.pane_id, (.display_agent // .agent // ""), (.label // ""), (.title // "")]
           | join("\u001f")' \
  | while IFS=$'\x1f' read -r id agent name title; do
      want="${agent:+$agent - }$id${name:+ · $name}"
      # Herdr truncates titles to 80 characters; compare what it will store.
      want="${want:0:80}"
      [ "$want" = "$title" ] \
        || "$herdr" pane report-metadata "$id" --source pane-id-labels --title "$want" >/dev/null 2>&1
    done
