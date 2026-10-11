return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      filters = {
        git_ignored = false,
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        find_files = {
          no_ignore = true,
        },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      -- ensure luasnip is used
      local luasnip = require "luasnip"

      opts.snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      }

      return opts
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufEnter" },
    config = function()
      require "configs.lint"
    end,
  },

  -- debugger (loads only when one of the keys below is pressed)
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "suketa/nvim-dap-ruby",
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug toggle breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Debug start/continue" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Debug step over" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Debug step into" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Debug step out" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Debug terminate" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Debug toggle UI" },
      { "<leader>de", function() require("dapui").eval() end, mode = { "n", "v" }, desc = "Debug eval expression" },
    },
    config = function()
      require "configs.dap"
    end,
  },

  {
    "luukvbaal/statuscol.nvim",
    lazy = false, -- NvChad lazy-loads plugins by default; the gutter must be ready immediately
    config = function()
      require "configs.statuscol"
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy", -- load right after startup so z / <leader> popups work immediately
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "json",
        "jsonc",
      },
    },
  },
}
