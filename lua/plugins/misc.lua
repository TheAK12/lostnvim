-- ── Misc ─────────────────────────────────────────────────────

return {
  -- ── Discord Rich Presence ────────────────────────────────
  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    opts = {
      neovim_image_text = "Neovim",
      main_image = "neovim",
      debounce_timeout = 10,
      editing_text = "Editing %s",
      file_explorer_text = "Browsing files",
      git_commit_text = "Committing changes",
      reading_text = "Reading %s",
    },
  },

  -- ── Neoscroll (smooth scrolling) ─────────────────────────
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {
      mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      easing = "sine",
      performance_mode = false,
    },
  },

  -- ── Auto-save ────────────────────────────────────────────
  {
    "okuuva/auto-save.nvim",
    event = { "InsertLeave", "TextChanged" },
    opts = {
      trigger_events = {
        immediate_save = { "BufLeave", "FocusLost" },
        defer_save = { "InsertLeave", "TextChanged" },
      },
      condition = function(buf)
        local fn = vim.fn
        -- Don't auto-save special buffers
        if fn.getbufvar(buf, "&modifiable") == 0 then return false end
        if fn.getbufvar(buf, "&filetype") == "oil" then return false end
        if fn.getbufvar(buf, "&filetype") == "harpoon" then return false end
        return true
      end,
      debounce_delay = 2000,
    },
  },

  -- ── Grug-far (find and replace) ──────────────────────────
  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    keys = {
      { "<leader>sr", "<cmd>GrugFar<CR>", desc = "Search & Replace" },
      {
        "<leader>sw",
        function()
          require("grug-far").open { prefills = { search = vim.fn.expand "<cword>" } }
        end,
        desc = "Replace word under cursor",
      },
      {
        "<leader>sr",
        function()
          require("grug-far").with_visual_selection()
        end,
        mode = "v",
        desc = "Search & Replace (selection)",
      },
    },
    opts = {
      headerMaxWidth = 80,
    },
  },

  -- ── Hlslens (search match count) ────────────────────────
  {
    "kevinhwang91/nvim-hlslens",
    event = "CmdlineEnter",
    keys = {
      { "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR>zz<Cmd>lua require('hlslens').start()<CR>]], desc = "Next match" },
      { "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR>zz<Cmd>lua require('hlslens').start()<CR>]], desc = "Previous match" },
      { "*", [[*<Cmd>lua require('hlslens').start()<CR>]], desc = "Search word forward" },
      { "#", [[#<Cmd>lua require('hlslens').start()<CR>]], desc = "Search word backward" },
    },
    opts = {
      calm_down = true,
      nearest_only = true,
    },
  },

  -- ── Project detection ────────────────────────────────────
  {
    "coffebar/project.nvim",
    event = "VeryLazy",
    config = function()
      require("project_nvim").setup {
        detection_methods = { "pattern", "lsp" },
        patterns = { ".git", "Makefile", "package.json", "Cargo.toml", "go.mod", "pyproject.toml" },
        silent_chdir = true,
      }
    end,
  },

  -- ── Session management ────────────────────────────────────
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore session" },
      { "<leader>qS", function() require("persistence").select() end, desc = "Select session" },
      { "<leader>ql", function() require("persistence").load { last = true } end, desc = "Restore last session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't save current session" },
    },
  },

  -- ── Guess indent ─────────────────────────────────────────
  {
    "NMAC427/guess-indent.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- ── Plenary (utility library) ────────────────────────────
  { "nvim-lua/plenary.nvim", lazy = true },

  -- ── Nvim-nio (async I/O) ─────────────────────────────────
  { "nvim-neotest/nvim-nio", lazy = true },

  -- ── SQLite (for yanky persistence) ───────────────────────
  { "kkharji/sqlite.lua", lazy = true },
}
