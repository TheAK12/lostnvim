-- You can also add or configure plugins by creating files in this `plugins/` folder
-- PLEASE REMOVE THE EXAMPLES YOU HAVE NO INTEREST IN BEFORE ENABLING THIS FILE
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==
  {
    "aikhe/wrapped.nvim",
    dependencies = { "nvzone/volt", "nvim-lua/plenary.nvim" },
    cmd = { "NvimWrapped" },
    opts = {},
  },
  "andweeb/presence.nvim",

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        width = 68,
        preset = {
          header = table.concat({
            "",
            "  ╦  ╔═╗╔═╗╔╦╗  ╔╗╔╦  ╦╦╔╦╗",
            "  ║  ║ ║╚═╗ ║   ║║║╚╗╔╝║║║║",
            "  ╩═╝╚═╝╚═╝ ╩   ╝╚╝ ╚╝ ╩╩ ╩",
            "",
          }, "\n"),
          keys = {
            { icon = "󰈞 ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = "󰊄 ", key = "g", desc = "Grep Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = "󰋚 ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = "󰈔 ", key = "n", desc = "New File", action = ":ene | startinsert" },
            {
              icon = "󰒓 ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = "󰦛 ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy" },
            { icon = "󰩈 ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          {
            icon = " ",
            title = "Recent Files",
            section = "recent_files",
            indent = 2,
            padding = 1,
            limit = 5,
            cwd = true,
          },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1, limit = 5 },
          {
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function() return Snacks.git.get_root() ~= nil end,
            cmd = "git --no-pager diff --stat -B -M -C || true",
            height = 5,
            padding = 1,
            indent = 3,
            ttl = 5 * 60,
          },
          { section = "startup" },
        },
      },
    },
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts)
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },
}
