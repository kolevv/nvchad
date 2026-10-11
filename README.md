# Neovim config

Built on [NvChad](https://github.com/NvChad/NvChad) v2.5 (used as a plugin). Leader is `<space>`. Theme: `bearded-arc`.

Tools (LSP servers, linters, formatters, debuggers) are installed with `:Mason`.

## Layout

| File                        | Purpose                    |
| --------------------------- | -------------------------- |
| `lua/plugins/init.lua`      | Plugin specs               |
| `lua/configs/lspconfig.lua` | LSP servers                |
| `lua/configs/conform.lua`   | Formatters                 |
| `lua/configs/lint.lua`      | Linters                    |
| `lua/configs/dap.lua`       | Debugger                   |
| `lua/configs/statuscol.lua` | Gutter layout              |
| `lua/mappings.lua`          | Keymaps                    |
| `lua/options.lua`           | Options, gitsigns, folding |
| `lua/autocmds.lua`          | Fold method per filetype   |

## How tools load

- **LSP** (`nvim-lspconfig` + `vim.lsp.enable`): a server starts only when a file of its filetype is opened. Names must match the files in `nvim-lspconfig/lsp/`, not the Mason package names (e.g. `ruby_lsp`, not `ruby-lsp`). Check with `:checkhealth vim.lsp`.
- **Formatting** (`conform.nvim`): format on save, falls back to the LSP when no formatter is set for the filetype.
- **Linting** (`nvim-lint`): runs on save and on leaving insert mode, per filetype.
- **Debugging** (`nvim-dap`): loads on the first `<leader>d…` keypress.

## Languages

### Ruby

| Tool         | Role                                                       |
| ------------ | ---------------------------------------------------------- |
| `ruby_lsp`   | LSP (also formats on save via LSP fallback)                |
| `standardrb` | Linter                                                     |
| `rdbg`       | Debugger, via `nvim-dap` + `nvim-dap-ruby` + `nvim-dap-ui` |

In Bundler projects the `debug` gem must be in the Gemfile for `rdbg` to launch.

### Python

| Tool          | Role                                |
| ------------- | ----------------------------------- |
| `pylsp`       | LSP (its pylint plugin is disabled) |
| `pylint`      | Linter                              |
| `ruff_format` | Formatter                           |

`pylsp` and `pylint` use `.venv/bin/` from the directory nvim was started in when present, otherwise the Mason/global binary.

### JavaScript / TypeScript

| Tool       | Role                         |
| ---------- | ---------------------------- |
| `vtsls`    | LSP                          |
| `prettier` | Formatter (js, ts, jsx, tsx) |

### HTML / CSS

| Tool            | Role      |
| --------------- | --------- |
| `html`, `cssls` | LSP       |
| `prettier`      | Formatter |

### Lua

| Tool     | Role      |
| -------- | --------- |
| `lua_ls` | LSP       |
| `stylua` | Formatter |

### Other

- **Docker**: `dockerls` LSP.
- **JSON / YAML / Markdown**: `prettier` formatter.

## Keymaps

Only the ones added on top of NvChad's defaults (`<leader>ch` shows the full cheatsheet).

### General

| Key           | Action             |
| ------------- | ------------------ |
| `;`           | Enter command mode |
| `jk` (insert) | Escape             |

### LSP

| Key          | Action                          |
| ------------ | ------------------------------- |
| `<leader>fr` | Find all references (Telescope) |
| `<leader>ww` | Code actions                    |

### Git

| Key          | Action                         |
| ------------ | ------------------------------ |
| `<leader>gy` | Blame for current line (popup) |
| `<leader>gb` | Blame for whole buffer         |
| `<leader>gd` | Toggle intra-line word diff    |

### Debugger

| Key          | Action                                                |
| ------------ | ----------------------------------------------------- |
| `<leader>db` | Toggle breakpoint                                     |
| `<leader>dc` | Start / continue (prompts for a launch configuration) |
| `<leader>do` | Step over                                             |
| `<leader>di` | Step into                                             |
| `<leader>dO` | Step out                                              |
| `<leader>dt` | Terminate                                             |
| `<leader>du` | Toggle the UI                                         |
| `<leader>de` | Evaluate expression under cursor or selection         |

The UI opens when a session starts and closes when it ends. `<leader>ds` is NvChad's diagnostics loclist, so it is not used here.

## Editor

- **Git** (`gitsigns.nvim`): gutter signs for staged and unstaged changes, inline blame on the current line after 1s.
- **Folding**: treesitter folds where a parser exists, indent folds otherwise; all folds open by default; custom fold text in `lua/utils/foldtext.lua`.
- **Gutter** (`statuscol.nvim`): signs, line numbers, then clickable fold chevrons.
- **Completion** (`nvim-cmp` + `LuaSnip`): VS Code-style snippets from `friendly-snippets`, loaded lazily.
- **File tree** (`nvim-tree`): git-ignored files are shown.
- **Telescope**: `find_files` includes git-ignored files.
- **which-key**: loaded right after startup.
- **Treesitter parsers**: vim, lua, vimdoc, html, css, json, jsonc.
