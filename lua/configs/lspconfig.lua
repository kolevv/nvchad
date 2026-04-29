require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "ts_ls", "dockerls", "lua_ls" }
vim.lsp.enable(servers)

-- configure pylsp separately to use the venv binary
local venv_pylsp = vim.fn.getcwd() .. "/.venv/bin/pylsp"
local pylsp_cmd = vim.fn.executable(venv_pylsp) == 1 and { venv_pylsp } or { "pylsp" }

vim.lsp.config("pylsp", {
  cmd = pylsp_cmd,
  settings = {
    pylsp = {
      plugins = {
        pylint = { enabled = false }, -- you're handling this via nvim-lint
      },
    },
  },
})
vim.lsp.enable "pylsp"

-- read :h vim.lsp.config for changing options of lsp servers
