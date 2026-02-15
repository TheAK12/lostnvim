-- ── Editor ───────────────────────────────────────────────────

return {
  -- ── Autopairs ────────────────────────────────────────────
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
      },
    },
  },

  -- ── Mini.surround ────────────────────────────────────────
  {
    "echasnovski/mini.surround",
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      mappings = {
        add = "gsa",
        delete = "gsd",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        replace = "gsr",
        update_n_lines = "gsn",
      },
    },
  },

  -- ── Mini.ai (better textobjects) ────────────────────────
  {
    "echasnovski/mini.ai",
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      local ai = require "mini.ai"
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter { -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          },
          f = ai.gen_spec.treesitter { a = "@function.outer", i = "@function.inner" },
          c = ai.gen_spec.treesitter { a = "@class.outer", i = "@class.inner" },
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().googl*()</googl*>" },
          d = { "%f[%d]%d+" }, -- digits
          e = { -- word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          u = ai.gen_spec.function_call(), -- function call
          U = ai.gen_spec.function_call { name_pattern = "[%w_]" }, -- function call without dot
        },
      }
    end,
  },

  -- ── Mini.bracketed ───────────────────────────────────────
  {
    "echasnovski/mini.bracketed",
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- ── Flash.nvim (jump anywhere) ───────────────────────────
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      labels = "asdfghjklqwertyuiopzxcvbnm",
      modes = {
        char = { enabled = true },
        search = { enabled = false },
      },
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<C-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- ── vim-matchup (extended %) ─────────────────────────────
  {
    "andymass/vim-matchup",
    event = { "BufReadPost", "BufNewFile" },
    init = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  -- ── Undotree ─────────────────────────────────────────────
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Undotree" },
    },
  },

  -- ── Yanky (yank ring) ───────────────────────────────────
  {
    "gbprod/yanky.nvim",
    dependencies = { "kkharji/sqlite.lua" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ring = { storage = "sqlite" },
      highlight = { on_put = true, on_yank = true, timer = 150 },
    },
    keys = {
      -- stylua: ignore
      { "p", "<Plug>(YankyPutAfter)", mode = { "n" }, desc = "Put after cursor" },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n" }, desc = "Put before cursor" },
      { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put after (leave cursor)" },
      { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put before (leave cursor)" },
      { "<C-p>", "<Plug>(YankyPreviousEntry)", desc = "Yank ring prev" },
      { "<C-n>", "<Plug>(YankyNextEntry)", desc = "Yank ring next" },
    },
  },

  -- ── Todo comments ────────────────────────────────────────
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous TODO" },
      { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "TODO (Trouble)" },
      { "<leader>ft", "<cmd>TodoFzfLua<CR>", desc = "Find TODOs" },
    },
  },

  -- ── Dial (smart increment/decrement) ─────────────────────
  {
    "monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
      { "<C-a>", function() return require("dial.map").inc_visual() end, mode = "v", expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_visual() end, mode = "v", expr = true, desc = "Decrement" },
      { "g<C-a>", function() return require("dial.map").inc_gvisual() end, mode = "v", expr = true, desc = "Increment (g)" },
      { "g<C-x>", function() return require("dial.map").dec_gvisual() end, mode = "v", expr = true, desc = "Decrement (g)" },
    },
    config = function()
      local augend = require "dial.augend"
      require("dial.config").augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.constant.new { elements = { "let", "const" } },
          augend.constant.new { elements = { "true", "false" } },
          augend.constant.new { elements = { "True", "False" } },
          augend.constant.new { elements = { "yes", "no" } },
          augend.constant.new { elements = { "and", "or" } },
          augend.constant.new { elements = { "&&", "||" }, word = false },
        },
      }
    end,
  },

  -- ── Rainbow delimiters ───────────────────────────────────
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("rainbow-delimiters.setup").setup {
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
    end,
  },

  -- ── Refactoring ──────────────────────────────────────────
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    keys = {
      {
        "<leader>cr",
        function() require("refactoring").select_refactor() end,
        mode = { "n", "x" },
        desc = "Refactor",
      },
    },
    opts = {},
  },
}
