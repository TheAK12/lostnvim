return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      filetypes = {
        ["*"] = true, -- attach to all files
      },

      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<C-l>", -- Ctrl+L to accept (no conflict)
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
}
