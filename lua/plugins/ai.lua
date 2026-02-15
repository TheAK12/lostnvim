-- ── AI ───────────────────────────────────────────────────────

return {
  -- ── GitHub Copilot ───────────────────────────────────────
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      filetypes = {
        ["*"] = true,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<C-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = {
        enabled = true,
        auto_refresh = true,
      },
    },
  },

  -- ── Blink-copilot (copilot source for blink.cmp) ────────
  { "giuxtaposition/blink-cmp-copilot", lazy = true },

  -- ── OpenCode ─────────────────────────────────────────────
  {
    "nickjvandyke/opencode.nvim",
    dependencies = {
      -- Required for ask(), select(), and snacks provider
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {}

      -- Required for auto-reload when opencode edits files
      vim.o.autoread = true

      -- Toggle opencode terminal
      vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle OpenCode" })

      -- Ask opencode (with context)
      vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask OpenCode" })

      -- Open action picker
      vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end, { desc = "OpenCode select action" })

      -- Operator: add range to opencode prompt
      vim.keymap.set({ "n", "x" }, "<leader>oo", function() return require("opencode").operator("@this ") end, { desc = "OpenCode operator", expr = true })

      -- Scroll opencode session
      vim.keymap.set("n", "<leader>ou", function() require("opencode").command("session.half.page.up") end, { desc = "Scroll OpenCode up" })
      vim.keymap.set("n", "<leader>od", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll OpenCode down" })
    end,
  },
}
