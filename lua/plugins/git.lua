-- ── Git ──────────────────────────────────────────────────────

return {
  -- ── Gitsigns ─────────────────────────────────────────────
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      current_line_blame = false,
      current_line_blame_opts = { delay = 300 },
      on_attach = function(bufnr)
        local gs = require "gitsigns"
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Navigation
        map("n", "]g", function() gs.nav_hunk "next" end, "Next git hunk")
        map("n", "[g", function() gs.nav_hunk "prev" end, "Previous git hunk")

        -- Actions
        map("n", "<leader>ghs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>ghr", gs.reset_hunk, "Reset hunk")
        map("v", "<leader>ghs", function() gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" } end, "Stage hunk")
        map("v", "<leader>ghr", function() gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" } end, "Reset hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo stage hunk")
        map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview hunk inline")
        map("n", "<leader>ghb", function() gs.blame_line { full = true } end, "Blame line")
        map("n", "<leader>ghd", gs.diffthis, "Diff this")
        map("n", "<leader>ghD", function() gs.diffthis "~" end, "Diff this (cached)")
      end,
    },
  },

  -- ── Neogit ───────────────────────────────────────────────
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "ibhagwan/fzf-lua",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit" },
      { "<leader>gc", "<cmd>Neogit commit<CR>", desc = "Neogit commit" },
      { "<leader>gp", "<cmd>Neogit push<CR>", desc = "Neogit push" },
      { "<leader>gP", "<cmd>Neogit pull<CR>", desc = "Neogit pull" },
    },
    opts = {
      integrations = {
        diffview = true,
        fzf_lua = true,
      },
      signs = {
        hunk = { "", "" },
        item = { "▸", "▾" },
        section = { "▸", "▾" },
      },
    },
  },

  -- ── Diffview ─────────────────────────────────────────────
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diffview open" },
      { "<leader>gD", "<cmd>DiffviewClose<CR>", desc = "Diffview close" },
      { "<leader>gfh", "<cmd>DiffviewFileHistory %<CR>", desc = "File history" },
      { "<leader>gfH", "<cmd>DiffviewFileHistory<CR>", desc = "Branch history" },
    },
    opts = {
      enhanced_diff_hl = true,
    },
  },

  -- ── Git blame ────────────────────────────────────────────
  {
    "f-person/git-blame.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      enabled = false, -- Start disabled, toggle with keybind
      date_format = "%Y-%m-%d",
      message_template = "  <author> | <date> | <summary>",
      virtual_text_column = 80,
    },
    keys = {
      { "<leader>gB", "<cmd>GitBlameToggle<CR>", desc = "Toggle git blame" },
    },
  },
}
