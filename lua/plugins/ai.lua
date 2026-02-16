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
    "NickvanDyke/opencode.nvim",
    dependencies = {
      { "folke/snacks.nvim", opts = { input = { enabled = true }, picker = { enabled = true }, terminal = { enabled = true } } },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {}

      -- Required for auto-reload when opencode edits files
      vim.o.autoread = true

      local oc = require("opencode")
      local prefix = "<Leader>O"

      -- Normal mode
      vim.keymap.set({ "n", "t" }, "<C-.>", oc.toggle, { desc = "Toggle OpenCode" })
      vim.keymap.set("n", prefix .. "t", oc.toggle, { desc = "OpenCode toggle embedded" })
      vim.keymap.set("n", prefix .. "a", function() oc.ask("@this: ", { submit = true }) end, { desc = "OpenCode ask about this" })
      vim.keymap.set("n", prefix .. "+", function() oc.prompt("@buffer", { append = true }) end, { desc = "OpenCode add buffer to prompt" })
      vim.keymap.set("n", prefix .. "e", function() oc.prompt("Explain @this and its context", { submit = true }) end, { desc = "OpenCode explain this code" })
      vim.keymap.set("n", prefix .. "n", function() oc.command("session.new") end, { desc = "OpenCode new session" })
      vim.keymap.set("n", prefix .. "s", oc.select, { desc = "OpenCode select prompt" })
      vim.keymap.set("n", "<S-C-u>", function() oc.command("session.half.page.up") end, { desc = "OpenCode messages half page up" })
      vim.keymap.set("n", "<S-C-d>", function() oc.command("session.half.page.down") end, { desc = "OpenCode messages half page down" })

      -- Visual mode
      vim.keymap.set("v", prefix .. "a", function() oc.ask("@this: ", { submit = true }) end, { desc = "OpenCode ask about selection" })
      vim.keymap.set("v", prefix .. "+", function() oc.prompt("@this") end, { desc = "OpenCode add selection to prompt" })
      vim.keymap.set("v", prefix .. "s", oc.select, { desc = "OpenCode select prompt" })
    end,
  },
}
