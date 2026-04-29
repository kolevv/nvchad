local lint = require "lint"

lint.linters_by_ft = {
  python = { "pylint" },
}

-- use the venv's pylint so it finds your installed packages
local venv_pylint = vim.fn.getcwd() .. "/.venv/bin/pylint"
if vim.fn.executable(venv_pylint) == 1 then
  lint.linters.pylint.cmd = venv_pylint
end

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
  callback = function()
    lint.try_lint()
  end,
})
