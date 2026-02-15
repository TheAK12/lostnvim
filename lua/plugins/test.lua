-- ── Test (Neotest) ───────────────────────────────────────────

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- Adapters
      "fredrikaverpil/neotest-golang",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-jest",
      "mrcjkb/rustaceanvim",
    },
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>tT", function() require("neotest").run.run(vim.fn.expand "%") end, desc = "Run file tests" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Test summary" },
      { "<leader>to", function() require("neotest").output.open { enter_on_open = true } end, desc = "Test output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Test output panel" },
      { "<leader>td", function() require("neotest").run.run { strategy = "dap" } end, desc = "Debug nearest test" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop test" },
      { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand "%") end, desc = "Watch file tests" },
      { "]T", function() require("neotest").jump.next { status = "failed" } end, desc = "Next failed test" },
      { "[T", function() require("neotest").jump.prev { status = "failed" } end, desc = "Previous failed test" },
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-golang" {
            recursive_run = true,
          },
          require "neotest-python" {
            dap = { justMyCode = false },
            runner = "pytest",
          },
          require "neotest-jest" {
            jestCommand = "npx jest",
            jestConfigFile = function(file)
              if string.find(file, "/packages/") then
                return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
              end
              return vim.fn.getcwd() .. "/jest.config.ts"
            end,
          },
          require "rustaceanvim.neotest",
        },
        status = {
          virtual_text = true,
          signs = true,
        },
        output = {
          open_on_run = true,
        },
        quickfix = {
          open = function()
            require("trouble").open { mode = "quickfix", focus = false }
          end,
        },
        icons = {
          passed = "✔",
          failed = "✖",
          running = "⟳",
          skipped = "⊘",
          unknown = "?",
        },
      }
    end,
  },

  -- ── Adapters ─────────────────────────────────────────────
  { "fredrikaverpil/neotest-golang", lazy = true },
  { "nvim-neotest/neotest-python", lazy = true },
  { "nvim-neotest/neotest-jest", lazy = true },
}
