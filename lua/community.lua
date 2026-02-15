-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",

  -- ── AI ─────────────────────────────────────────────────────────
  { import = "astrocommunity.ai.opencode-nvim" },

  -- ── Completion ─────────────────────────────────────────────────
  { import = "astrocommunity.completion.blink-cmp" },
  { import = "astrocommunity.completion.blink-copilot" },
  { import = "astrocommunity.completion.copilot-cmp" },

  -- ── Colorscheme ────────────────────────────────────────────────
  { import = "astrocommunity.colorscheme.everblush-nvim" },

  -- ── Editing Support ────────────────────────────────────────────
  { import = "astrocommunity.editing-support.auto-save-nvim" }, -- auto-save on focus lost / buffer leave
  { import = "astrocommunity.editing-support.bigfile-nvim" }, -- disable heavy features on large files
  { import = "astrocommunity.editing-support.conform-nvim" }, -- lightweight formatter engine
  { import = "astrocommunity.editing-support.dial-nvim" }, -- increment/decrement dates, booleans, etc.
  { import = "astrocommunity.editing-support.nvim-treesitter-context" }, -- sticky function/class header
  { import = "astrocommunity.editing-support.nvim-treesitter-endwise" }, -- auto-add end/fi/done in ruby/bash/lua
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" }, -- rainbow brackets/parens
  { import = "astrocommunity.editing-support.refactoring-nvim" }, -- treesitter-based refactoring
  { import = "astrocommunity.editing-support.todo-comments-nvim" }, -- highlight TODO/FIXME/HACK/NOTE
  { import = "astrocommunity.editing-support.undotree" }, -- visual undo history
  { import = "astrocommunity.editing-support.yanky-nvim" }, -- yank ring / improved paste
  { import = "astrocommunity.editing-support.wildfire-nvim" }, -- smart incremental selection

  -- ── Motion ─────────────────────────────────────────────────────
  { import = "astrocommunity.motion.flash-nvim" }, -- leap/sneak replacement, label-based jumps
  { import = "astrocommunity.motion.mini-ai" }, -- better around/inside textobjects
  { import = "astrocommunity.motion.mini-bracketed" }, -- bracket-based navigation [b ]b [q ]q etc.
  { import = "astrocommunity.motion.mini-move" }, -- move lines/selections with Alt+hjkl
  { import = "astrocommunity.motion.mini-surround" }, -- add/delete/replace surroundings
  { import = "astrocommunity.motion.nvim-spider" }, -- camelCase-aware w/e/b motions
  { import = "astrocommunity.motion.vim-matchup" }, -- extended % matching

  -- ── Git ────────────────────────────────────────────────────────
  { import = "astrocommunity.git.diffview-nvim" }, -- tabpage diff viewer
  { import = "astrocommunity.git.git-blame-nvim" }, -- inline git blame
  { import = "astrocommunity.git.neogit" }, -- magit-style git interface
  { import = "astrocommunity.git.octo-nvim" }, -- GitHub issues & PRs inside nvim

  -- ── Diagnostics ────────────────────────────────────────────────
  { import = "astrocommunity.diagnostics.trouble-nvim" }, -- pretty diagnostics list
  { import = "astrocommunity.diagnostics.tiny-inline-diagnostic-nvim" }, -- inline diagnostic messages

  -- ── LSP ────────────────────────────────────────────────────────
  { import = "astrocommunity.lsp.actions-preview-nvim" }, -- preview code actions before applying
  { import = "astrocommunity.lsp.garbage-day-nvim" }, -- auto-stop inactive LSP servers
  { import = "astrocommunity.lsp.inc-rename-nvim" }, -- incremental LSP rename with preview
  { import = "astrocommunity.lsp.nvim-lsp-endhints" }, -- show type hints at end of line
  { import = "astrocommunity.lsp.nvim-lsp-file-operations" }, -- rename/move files updates imports
  { import = "astrocommunity.lsp.nvim-lint" }, -- async linter engine

  -- ── Debugging ──────────────────────────────────────────────────
  { import = "astrocommunity.debugging.nvim-dap-virtual-text" }, -- inline variable values while debugging
  { import = "astrocommunity.debugging.persistent-breakpoints-nvim" }, -- breakpoints persist across sessions

  -- ── Test ───────────────────────────────────────────────────────
  { import = "astrocommunity.test.neotest" }, -- unified test runner framework

  -- ── Indent ─────────────────────────────────────────────────────
  { import = "astrocommunity.indent.indent-blankline-nvim" }, -- indent guides
  { import = "astrocommunity.indent.mini-indentscope" }, -- animated current scope indicator

  -- ── Scrolling ──────────────────────────────────────────────────
  { import = "astrocommunity.scrolling.neoscroll-nvim" }, -- smooth scrolling animations
  { import = "astrocommunity.scrolling.nvim-scrollbar" }, -- scrollbar with diagnostics/search marks

  -- ── File Explorer ──────────────────────────────────────────────
  { import = "astrocommunity.file-explorer.oil-nvim" }, -- edit filesystem like a buffer

  -- ── Fuzzy Finder ───────────────────────────────────────────────
  { import = "astrocommunity.fuzzy-finder.fzf-lua" }, -- fast fzf-native picker

  -- ── Search ─────────────────────────────────────────────────────
  { import = "astrocommunity.search.grug-far-nvim" }, -- find and replace across files
  { import = "astrocommunity.search.nvim-hlslens" }, -- search match count + virtual text

  -- ── Project ────────────────────────────────────────────────────
  { import = "astrocommunity.project.project-nvim" }, -- auto-detect project root

  -- ── Split & Window ─────────────────────────────────────────────
  { import = "astrocommunity.split-and-window.colorful-winsep-nvim" }, -- colored active window separator

  -- ── Bars & Lines ───────────────────────────────────────────────
  { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" }, -- show colorcolumn only when needed

  -- ── Terminal ───────────────────────────────────────────────────
  { import = "astrocommunity.terminal-integration.flatten-nvim" }, -- open files from nested terminals in parent nvim

  -- ── Utility ────────────────────────────────────────────────────
  { import = "astrocommunity.utility.mason-tool-installer-nvim" }, -- auto-install mason tools

  -- ── Markdown & LaTeX ───────────────────────────────────────────
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },

  -- ── Recipes ────────────────────────────────────────────────────
  { import = "astrocommunity.recipes.vscode-icons" }, -- VS Code-style file icons

  -- ── Language Packs ─────────────────────────────────────────────
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.full-dadbod" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.json" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.tailwindcss" },
}
