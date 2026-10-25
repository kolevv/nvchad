require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "vtsls", "dockerls", "lua_ls", "ruby_lsp" }
vim.lsp.enable(servers)

-- configure pylsp separately to use the nearest venv's binary (looked up from
-- the project root, not the startup cwd, so it works from any directory)
vim.lsp.config("pylsp", {
  cmd = function(dispatchers, config)
    local venv_root = config.root_dir and vim.fs.root(config.root_dir, ".venv")
    local venv_pylsp = venv_root and venv_root .. "/.venv/bin/pylsp"
    local bin = venv_pylsp and vim.fn.executable(venv_pylsp) == 1 and venv_pylsp or "pylsp"
    return vim.lsp.rpc.start({ bin }, dispatchers, { cwd = config.cmd_cwd or config.root_dir, env = config.cmd_env })
  end,
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
