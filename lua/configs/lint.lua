local lint = require "lint"

lint.linters_by_ft = {
  python = { "pylint" },
  ruby = { "standardrb" },
}

-- use the nearest venv's pylint (looked up from the current buffer, not the
-- startup cwd) so it finds your installed packages
lint.linters.pylint.cmd = function()
  local venv_root = vim.fs.root(0, ".venv")
  local venv_pylint = venv_root and venv_root .. "/.venv/bin/pylint"
  return venv_pylint and vim.fn.executable(venv_pylint) == 1 and venv_pylint or "pylint"
end

-- packages without __init__.py (e.g. harbour/app) only resolve when pylint
-- knows the source root, so pass the venv's directory as one
table.insert(lint.linters.pylint.args, 1, function()
  return "--source-roots=" .. (vim.fs.root(0, ".venv") or vim.fn.getcwd())
end)

-- standardrb exits 1 whenever it finds offenses; don't warn about that
lint.linters.standardrb.ignore_exitcode = true

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
  callback = function()
    lint.try_lint()
  end,
})
