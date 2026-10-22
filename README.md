# herdr-pane-id-labels

A [Herdr](https://herdr.dev) plugin that keeps every pane's Herdr pane ID visible and lets you copy it with one keybinding.

Herdr pane IDs (`w1:p2`) are what `herdr pane ...` and `herdr agent ...` commands take as targets, but Herdr itself never shows them. This plugin sets each pane's display title to

```
<agent> - <pane-id>            claude - w2H:p1
<pane-id>                      w2H:p4
<agent> - <pane-id> · <name>   claude - w3R:p6 · api-tests
```

so the ID appears in pane borders. The title is display-only pane metadata: your own pane names are never changed, and uninstalling the plugin leaves nothing behind.

## Install

Requires `jq`, plus a clipboard tool for the copy action: `pbcopy` (macOS) or `wl-copy`, `xclip`, or `xsel` (Linux).

```bash
herdr plugin install alikayhan/herdr-pane-id-labels
```

Titles are applied on the next Herdr server start and refreshed automatically as panes and agents change. To apply them right away, or after renaming a pane:

```bash
herdr plugin action invoke alikayhan.pane-id-labels.relabel
```

## Copy a pane ID

Add a keybinding to `~/.config/herdr/config.toml`:

```toml
[[keys.command]]
key = "prefix+y"
type = "plugin_action"
command = "alikayhan.pane-id-labels.copy-id"
description = "copy pane ID"
```

Then run `herdr server reload-config` and detach and reattach the client (`prefix+d`, then `herdr`). `prefix+y` copies the focused pane's ID and shows a toast. Plugin commands run on the Herdr server, so over `herdr --remote` the ID lands on the server's clipboard.

## Tips

- Single-pane workspaces have no border by default, so the title is hidden there. Set `pane_borders = "always"` under `[ui]` to always show it. The plugin toasts this reminder once on server start if the setting is off.
- Herdr caps titles at 80 characters, so very long pane names are cut off.
- Herdr's pane right-click menu is hard-coded as of 0.9.5, so the copy action cannot appear there; use the keybinding.

## Development

```bash
herdr plugin link /path/to/herdr-pane-id-labels
herdr plugin log list --plugin alikayhan.pane-id-labels
```

## License

[MIT](LICENSE)
