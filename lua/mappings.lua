require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- LSP
map("", "<leader>fr", "<cmd>Telescope lsp_references<CR>", { desc = "Find all references" })
map("n", "<leader>ww", vim.lsp.buf.code_action, { desc = "Code Actions" })

-- GitSigns
map("", "<leader>gy", "<cmd>Gitsigns blame_line<CR>", { desc = "Show blame information for current line in popup" })
map("", "<leader>gd", "<cmd>Gitsigns toggle_word_diff<CR>", { desc = "Show intra-line word-diff" })
map("", "<leader>gb", "<cmd>Gitsigns blame<CR>", { desc = "Show blame of current buffer" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
