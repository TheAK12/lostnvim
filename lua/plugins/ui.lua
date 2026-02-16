-- ── UI ───────────────────────────────────────────────────────

return {
  -- ── Lualine (statusline) ─────────────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = function()
      return {
        options = {
          theme = "rose-pine",
          globalstatus = true,
          disabled_filetypes = {
            statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" },
          },
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { { "mode", fmt = function(str) return str:sub(1, 3) end } },
          lualine_b = { "branch" },
          lualine_c = {
            { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " } },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
              "filename",
              path = 1, -- Relative path
              symbols = { modified = " ●", readonly = " 󰌾", unnamed = "[No Name]", newfile = "[New]" },
            },
          },
          lualine_x = {
            {
              function()
                local clients = vim.lsp.get_clients { bufnr = 0 }
                if #clients == 0 then return "" end
                local names = {}
                for _, c in ipairs(clients) do
                  if c.name ~= "copilot" then
                    table.insert(names, c.name)
                  end
                end
                if #names == 0 then return "" end
                return " " .. table.concat(names, ", ")
              end,
              color = { fg = "#9ccfd8" },
            },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return "  " .. os.date "%R"
            end,
          },
        },
        extensions = { "lazy", "toggleterm", "trouble", "oil", "fzf" },
      }
    end,
  },

  -- ── Which-key ────────────────────────────────────────────
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      delay = 300,
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
        mappings = true,
        rules = false,
      },
      spec = {
        { "<leader>b", group = "Buffers" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Debug" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>gf", group = "File history" },
        { "<leader>gh", group = "Hunks" },
        { "<leader>l", group = "LSP" },
        { "<leader>O", group = "AI/OpenCode" },
        { "<leader>q", group = "Quit/Session" },
        { "<leader>s", group = "Search/Replace" },
        { "<leader>t", group = "Test/Terminal" },
        { "<leader>x", group = "Diagnostics" },
      },
    },
    keys = {
      {
        "<leader>?",
        function() require("which-key").show { global = false } end,
        desc = "Buffer local keymaps",
      },
    },
  },

  -- ── Indent blankline ─────────────────────────────────────
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false }, -- Using mini.indentscope instead
      exclude = {
        filetypes = {
          "help",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "snacks_dashboard",
        },
      },
    },
  },

  -- ── Mini indentscope (animated scope line) ───────────────
  {
    "echasnovski/mini.indentscope",
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "snacks_dashboard",
          "oil",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- ── Scrollbar ────────────────────────────────────────────
  {
    "petertriho/nvim-scrollbar",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      show_in_active_only = true,
      handle = { blend = 30 },
      marks = {
        Search = { color = "#c4a7e7" },
        Error = { color = "#eb6f92" },
        Warn = { color = "#f6c177" },
        Info = { color = "#9ccfd8" },
        Hint = { color = "#c4a7e7" },
        Misc = { color = "#c4a7e7" },
      },
      excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
        "noice",
        "notify",
        "dashboard",
        "snacks_dashboard",
      },
    },
  },

  -- ── Color highlighter ────────────────────────────────────
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      render = "virtual",
      enable_named_colors = true,
      enable_tailwind = true,
    },
  },

  -- ── Smart column (colorcolumn only when needed) ──────────
  {
    "m4xshen/smartcolumn.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      colorcolumn = "120",
      disabled_filetypes = {
        "help",
        "text",
        "markdown",
        "dashboard",
        "snacks_dashboard",
        "lazy",
        "mason",
        "oil",
      },
    },
  },

  -- ── Fidget (LSP progress + notifications) ────────────────
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    opts = {
      progress = {
        display = {
          done_ttl = 3,
          done_icon = "✔",
          progress_icon = { pattern = "dots", period = 1 },
        },
      },
      notification = {
        window = {
          winblend = 0,
          border = "rounded",
        },
      },
    },
  },

  -- ── Mini icons ────────────────────────────────────────────
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      -- Ensure mini.icons mock is set up for plugins that check for it
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
}
