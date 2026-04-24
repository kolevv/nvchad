local lint = require "lint"

lint.linters_by_ft = {
  python = { "pylint" },
}

-- run linting automatically
vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
  callback = function()
    lint.try_lint()
  end,
})
