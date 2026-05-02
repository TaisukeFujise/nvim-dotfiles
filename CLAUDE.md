# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal Neovim configuration written in Lua, managed with [lazy.nvim](https://github.com/folke/lazy.nvim). There are no build steps, test suites, or lint commands — changes are validated by launching Neovim and observing behavior.

## File Structure

```
init.lua                  # Entry point: sets <Space> as leader, loads the 4 modules below
lua/config/
  lazy.lua                # Bootstraps lazy.nvim; imports plugin specs from config.plugins
  options.lua             # Global vim.opt settings
  keymaps.lua             # Global key mappings (timeout 300ms)
  plugins.lua             # All plugin specs (single file, ~300 lines)
lazy-lock.json            # Plugin version lockfile (auto-managed by lazy.nvim)
```

## Architecture

All plugin configuration lives in `lua/config/plugins.lua` as a single flat table of lazy.nvim specs. There are no per-plugin config files. Each spec declares its own `opts`, `config`, `keys`, `cmd`, `event`, and `dependencies` inline.

Load order at startup:
1. `init.lua` sets leader keys then requires `config.lazy`
2. `config.lazy` bootstraps lazy.nvim and imports specs from `config.plugins`
3. `config.options` and `config.keymaps` apply global settings

## Key Conventions

- **Leader key**: `<Space>`
- **Indentation**: 4-space tab width, actual tab characters (`expandtab` is off)
- **Splits**: open below and right
- **Clipboard**: system clipboard (`unnamedplus`)
- **CWD**: many picker commands use the current buffer's directory (`vim.fn.expand("%:p:h")`), not the project root

## Plugin Notes

- **snacks.nvim** handles file picker, live grep, buffers, recent files, explorer, dashboard, and git diff. Project roots are hardcoded to `~/Cursus`, `~/Road`, `~/Documents`.
- **oil.nvim** opens when a directory is passed to Neovim (`vim.api.nvim_create_autocmd("VimEnter")`).
- **noice.nvim** wraps nvim-notify; `background_colour` must be set in both noice's `views.notify` and nvim-notify's `opts` to avoid the `NotifyBackground` warning.
- **42-header.nvim** auto-updates on save with user `tafujise` / `tafujise@student.42jp`. Triggered by `<F1>` or `:Stdheader`.
- **LSP**: `lua_ls` and `clangd` only. Diagnostics use `✖ ` prefix. Configured via `nvim-lspconfig` v0.1.8 pinned.
- **toggleterm**: floating terminal at 70% width / 40% height on `<C-\>`. Lazygit opens at 90%/90% on `<leader>lg`.

## Making Changes

- Edit `lua/config/plugins.lua` to add, remove, or configure plugins.
- Edit `lua/config/options.lua` for editor settings and `lua/config/keymaps.lua` for global mappings.
- After editing, restart Neovim (or run `:Lazy sync` for plugin changes).
- `lazy-lock.json` is version-controlled; run `:Lazy update` to bump plugins and commit the updated lockfile.
