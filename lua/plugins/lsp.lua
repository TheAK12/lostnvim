-- ── LSP ──────────────────────────────────────────────────────

return {
  -- ── Mason (installer) ────────────────────────────────────
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    keys = { { "<leader>lm", "<cmd>Mason<CR>", desc = "Mason" } },
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- ── Mason-lspconfig (auto-install + auto-enable servers) ──
  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig", -- provides lsp/*.lua default configs
      "b0o/schemastore.nvim",
      { "folke/lazydev.nvim", ft = "lua", opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } } },
    },
    config = function()
      -- ── Diagnostic configuration ─────────────────────────
      vim.diagnostic.config {
        severity_sort = true,
        float = {
          border = "rounded",
          source = true,
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = "󰌵 ",
          },
        },
        underline = true,
        update_in_insert = false,
        virtual_text = false, -- Using tiny-inline-diagnostic instead
      }

      -- ── LSP keymaps on attach ────────────────────────────
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", function() require("fzf-lua").lsp_definitions() end, "Go to definition")
          map("gr", function() require("fzf-lua").lsp_references() end, "References")
          map("gI", function() require("fzf-lua").lsp_implementations() end, "Go to implementation")
          map("gy", function() require("fzf-lua").lsp_typedefs() end, "Go to type definition")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("K", vim.lsp.buf.hover, "Hover docs")
          map("gK", vim.lsp.buf.signature_help, "Signature help")
          map("<C-k>", vim.lsp.buf.signature_help, "Signature help", "i")
          map("<leader>la", function() require("actions-preview").code_actions() end, "Code actions")
          map("<leader>la", function() require("actions-preview").code_actions() end, "Code actions", "v")
          map("<leader>lr", function()
            vim.api.nvim_feedkeys(":IncRename " .. vim.fn.expand "<cword>", "n", false)
          end, "Rename")
          map("<leader>ld", function() require("fzf-lua").diagnostics_document() end, "Document diagnostics")
          map("<leader>lD", function() require("fzf-lua").diagnostics_workspace() end, "Workspace diagnostics")
          map("<leader>ls", function() require("fzf-lua").lsp_document_symbols() end, "Document symbols")
          map("<leader>lS", function() require("fzf-lua").lsp_workspace_symbols() end, "Workspace symbols")
          map("<leader>li", "<cmd>LspInfo<CR>", "LSP info")
          map("<leader>lR", "<cmd>LspRestart<CR>", "LSP restart")

          -- Inlay hints toggle
          if vim.lsp.inlay_hint then
            map("<leader>lh", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, "Toggle inlay hints")
          end
        end,
      })

      -- ── Per-server configurations via vim.lsp.config() ───
      -- (blink.cmp auto-patches capabilities on Neovim 0.11+,
      --  no need to manually set capabilities)

      -- Lua
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            codeLens = { enable = true },
            completion = { callSnippet = "Replace" },
            doc = { privateName = { "^_" } },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = "Disable",
              semicolon = "Disable",
              arrayIndex = "Disable",
            },
            format = { enable = false }, -- Using stylua via conform
          },
        },
      })

      -- Python
      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "standard",
              autoImportCompletions = true,
              diagnosticSeverityOverrides = {
                reportUnusedImport = "information",
                reportUnusedVariable = "information",
              },
            },
          },
        },
      })

      -- TypeScript
      vim.lsp.config("ts_ls", {
        settings = {
          completions = { completeFunctionCalls = true },
        },
      })

      -- Go
      vim.lsp.config("gopls", {
        settings = {
          gopls = {
            gofumpt = true,
            codelenses = {
              gc_details = false,
              generate = true,
              regenerate_cgo = true,
              run_govulncheck = true,
              test = true,
              tidy = true,
              upgrade_dependency = true,
              vendor = true,
            },
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              fieldalignment = true,
              nilness = true,
              unusedparams = true,
              unusedwrite = true,
              useany = true,
            },
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            directoryFilters = { "-.git", "-.vscode", "-.idea", "-.venv", "-node_modules" },
            semanticTokens = true,
          },
        },
      })

      -- Rust: rustaceanvim handles rust-analyzer automatically

      -- C/C++
      vim.lsp.config("clangd", {
        capabilities = {
          offsetEncoding = { "utf-16" },
        },
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
      })

      -- Emmet (custom filetypes)
      vim.lsp.config("emmet_ls", {
        filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
      })

      -- JSON (with schemastore)
      vim.lsp.config("jsonls", {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      -- YAML (with schemastore)
      vim.lsp.config("yamlls", {
        settings = {
          yaml = {
            schemaStore = { enable = false, url = "" },
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      })

      -- Servers with default settings (no custom config needed):
      -- bashls, dockerls, docker_compose_language_service, html,
      -- cssls, tailwindcss, taplo, sqls, marksman
      -- (nvim-lspconfig provides their defaults via lsp/*.lua,
      --  mason-lspconfig auto-enables them)

      -- ── Mason-lspconfig setup ────────────────────────────
      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",
          "basedpyright",
          "ts_ls",
          "gopls",
          "rust_analyzer",
          "clangd",
          "bashls",
          "dockerls",
          "docker_compose_language_service",
          "html",
          "cssls",
          "emmet_ls",
          "tailwindcss",
          "jsonls",
          "yamlls",
          "taplo",
          "sqls",
          "marksman",
        },
        automatic_enable = {
          exclude = { "rust_analyzer" }, -- rustaceanvim handles this
        },
      }
    end,
  },

  -- ── Conform (formatting) ─────────────────────────────────
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>lf",
        function() require("conform").format { async = true, lsp_format = "fallback" } end,
        mode = { "n", "v" },
        desc = "Format",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format", "ruff_organize_imports" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        jsonc = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        go = { "goimports", "gofumpt" },
        rust = { "rustfmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        toml = { "taplo" },
        sql = { "sql_formatter" },
        ["_"] = { "trim_whitespace" },
      },
      format_on_save = function(bufnr)
        -- Disable for certain filetypes or large files
        if vim.b[bufnr].bigfile then return end
        return { timeout_ms = 3000, lsp_format = "fallback" }
      end,
    },
  },

  -- ── Nvim-lint (async linting) ────────────────────────────
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local lint = require "lint"
      lint.linters_by_ft = {
        lua = { "selene" },
        python = { "ruff" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        dockerfile = { "hadolint" },
        markdown = { "markdownlint" },
        go = { "golangcilint" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim_lint", { clear = true }),
        callback = function()
          if vim.bo.buftype == "" then
            lint.try_lint()
          end
        end,
      })
    end,
  },

  -- ── Trouble (diagnostics list) ───────────────────────────
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      focus = true,
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<CR>", desc = "Symbols (Trouble)" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix (Trouble)" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Loclist (Trouble)" },
    },
  },

  -- ── Tiny inline diagnostics ──────────────────────────────
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    opts = {
      preset = "modern",
      options = {
        show_source = true,
        multilines = true,
        throttle = 100,
      },
    },
  },

  -- ── Inc-rename (incremental rename) ──────────────────────
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    opts = {},
  },

  -- ── Actions preview ──────────────────────────────────────
  {
    "aznhe21/actions-preview.nvim",
    opts = {
      backend = { "fzf-lua", "nui" },
    },
  },

  -- ── LSP file operations ──────────────────────────────────
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "LspAttach",
    opts = {},
  },

  -- ── Garbage day (stop idle LSP servers) ──────────────────
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "LspAttach",
    opts = {},
  },

  -- ── LSP endhints (type hints at end of line) ─────────────
  {
    "chrisgrieser/nvim-lsp-endhints",
    event = "LspAttach",
    opts = {},
  },

  -- ── Mason tool installer ─────────────────────────────────
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "VeryLazy",
    cmd = { "MasonToolsInstall", "MasonToolsUpdate" },
    opts = {
      ensure_installed = {
        -- Formatters
        "stylua",
        "prettierd",
        "prettier",
        "shfmt",
        "goimports",
        "gofumpt",
        "ruff",
        "clang-format",
        "sql-formatter",
        -- Linters
        "selene",
        "eslint_d",
        "shellcheck",
        "hadolint",
        "markdownlint",
        "golangci-lint",
      },
      auto_update = false,
      run_on_start = true,
    },
  },

  -- ── Rustaceanvim ─────────────────────────────────────────
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    opts = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = { enable = true },
            },
            checkOnSave = true,
            check = { command = "clippy" },
            procMacro = { enable = true },
          },
        },
      },
    },
  },

  -- ── Clangd extensions ────────────────────────────────────
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp", "objc", "objcpp" },
    opts = {},
  },

  -- ── Crates.nvim (Cargo.toml) ─────────────────────────────
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = { cmp = { enabled = false }, crates = { enabled = true } },
      lsp = { enabled = true, actions = true, completion = true, hover = true },
    },
  },

  -- ── Go extras ────────────────────────────────────────────
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    build = function() vim.cmd.GoInstallDeps() end,
    opts = {},
  },

  -- ── Python venv selector ─────────────────────────────────
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    dependencies = { "neovim/nvim-lspconfig" },
    ft = "python",
    keys = { { "<leader>cv", "<cmd>VenvSelect<CR>", desc = "Select Python venv" } },
    opts = {},
  },

  -- ── Database ─────────────────────────────────────────────
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    keys = { { "<leader>D", "<cmd>DBUIToggle<CR>", desc = "Database UI" } },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },

  -- ── Render markdown ──────────────────────────────────────
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
}
