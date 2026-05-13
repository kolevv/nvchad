require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("", "<leader>fr", "<cmd>Telescope lsp_references<CR>", { desc = "Find all references" })
map("n", "<leader>ww", vim.lsp.buf.code_action, { desc = "Code Actions" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
