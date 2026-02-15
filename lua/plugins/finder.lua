-- ── Fuzzy Finder (fzf-lua) ───────────────────────────────────

return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    keys = {
      -- Find
      { "<leader>ff", "<cmd>FzfLua files<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<CR>", desc = "Live grep" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<CR>", desc = "Recent files" },
      { "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "Buffers" },
      { "<leader>fh", "<cmd>FzfLua help_tags<CR>", desc = "Help tags" },
      { "<leader>fw", "<cmd>FzfLua grep_cword<CR>", desc = "Grep word under cursor" },
      { "<leader>fW", "<cmd>FzfLua grep_cWORD<CR>", desc = "Grep WORD under cursor" },
      { "<leader>fc", function() require("fzf-lua").files { cwd = vim.fn.stdpath "config" } end, desc = "Find in config" },
      { "<leader>fk", "<cmd>FzfLua keymaps<CR>", desc = "Keymaps" },
      { "<leader>fm", "<cmd>FzfLua marks<CR>", desc = "Marks" },
      { "<leader>f/", "<cmd>FzfLua grep_last<CR>", desc = "Repeat last grep" },
      { "<leader>f:", "<cmd>FzfLua command_history<CR>", desc = "Command history" },
      { "<leader>fR", "<cmd>FzfLua registers<CR>", desc = "Registers" },

      -- Git pickers
      { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Git status" },
      { "<leader>gl", "<cmd>FzfLua git_log<CR>", desc = "Git log" },
      { "<leader>gb", "<cmd>FzfLua git_branches<CR>", desc = "Git branches" },
      { "<leader>gf", "<cmd>FzfLua git_files<CR>", desc = "Git files" },

      -- Search
      { "<leader>/", "<cmd>FzfLua grep_visual<CR>", mode = "v", desc = "Grep selection" },
      { "<leader>/", "<cmd>FzfLua live_grep<CR>", desc = "Live grep" },
    },
    opts = {
      -- Global opts
      "default-title",
      fzf_colors = true,
      winopts = {
        height = 0.85,
        width = 0.85,
        row = 0.35,
        col = 0.50,
        border = "rounded",
        preview = {
          layout = "flex",
          flip_columns = 150,
          scrollbar = "float",
        },
      },
      keymap = {
        builtin = {
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
        },
        fzf = {
          ["ctrl-q"] = "select-all+accept",
          ["ctrl-u"] = "half-page-up",
          ["ctrl-d"] = "half-page-down",
        },
      },
      files = {
        cwd_prompt = false,
        formatter = "path.filename_first",
      },
      grep = {
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
      },
      lsp = {
        symbols = {
          symbol_style = 1,
        },
      },
    },
  },
}
