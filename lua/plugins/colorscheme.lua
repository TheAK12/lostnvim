-- ── Colorscheme: Rose Pine ────────────────────────────────────

return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    lazy = false,
    opts = {
      variant = "moon",
      dark_variant = "moon",
      dim_inactive_windows = false,
      extend_background_behind_borders = true,

      styles = {
        bold = true,
        italic = true,
        transparency = false,
      },

      groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",
      },

      highlight_groups = {
        -- Cleaner float borders
        FloatBorder = { fg = "subtle", bg = "surface" },
        NormalFloat = { bg = "surface" },

        -- Telescope / picker styling
        TelescopeBorder = { fg = "subtle", bg = "surface" },
        TelescopeNormal = { bg = "surface" },
        TelescopePromptBorder = { fg = "subtle", bg = "surface" },
        TelescopePromptNormal = { bg = "surface" },
        TelescopeResultsBorder = { fg = "subtle", bg = "surface" },
        TelescopeResultsNormal = { bg = "surface" },
        TelescopePreviewBorder = { fg = "subtle", bg = "surface" },
        TelescopePreviewNormal = { bg = "surface" },

        -- Statusline
        StatusLine = { fg = "text", bg = "surface" },
        StatusLineNC = { fg = "subtle", bg = "base" },

        -- Cursorline
        CursorLine = { bg = "overlay" },
        CursorLineNr = { fg = "iris", bold = true },

        -- Visual
        Visual = { bg = "highlight_med" },

        -- Which-key
        WhichKeyFloat = { bg = "surface" },

        -- Blink completion
        BlinkCmpMenu = { bg = "surface" },
        BlinkCmpMenuBorder = { fg = "subtle", bg = "surface" },
        BlinkCmpDoc = { bg = "surface" },
        BlinkCmpDocBorder = { fg = "subtle", bg = "surface" },
      },
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)
      vim.cmd.colorscheme "rose-pine"
    end,
  },
}
