# LostNvim

**You were looking for an IDE. You found Neovim. Now you're lost.**

A from-scratch Neovim configuration built on [lazy.nvim](https://github.com/folke/lazy.nvim). No distro, no framework, no safety net — just ~65 plugins duct-taped together with Lua and mass delusion that this is somehow "simpler" than VS Code.

![Neovim](https://img.shields.io/badge/Neovim-0.11%2B-57A143?style=flat&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/Lua-2C2D72?style=flat&logo=lua&logoColor=white)
![Hours Lost](https://img.shields.io/badge/Hours_Lost-∞-red?style=flat)

## Why "LostNvim"?

Because every Neovim user goes through the same five stages:

1. "I'll just use a distro" (Denial)
2. "Actually, I'll write my own config from scratch" (Anger)
3. "Maybe if I add just one more plugin..." (Bargaining)
4. "Why does treesitter have a completely new API again" (Depression)
5. "This is fine. I am fine. `:wq`" (Acceptance)

You are here: **All of the above, simultaneously.**

## Features

- **~65 plugins** managed by lazy.nvim — each one added to fix a problem caused by the previous one
- **Rose Pine (Moon)** colorscheme, because we have taste (debatable)
- **Native LSP** for 18 languages with Neovim 0.11's `vim.lsp.config()` — no deprecated `require("lspconfig")` calls here, we live on the edge
- **Mason** auto-installs everything — LSP servers, formatters, linters, your will to use a normal editor
- **Autocompletion** via blink.cmp with Copilot, because typing is for people with free time
- **AI assistance** — GitHub Copilot + [OpenCode](https://opencode.ai), for when you want a robot to be confused by your code too
- **Fuzzy finding** with fzf-lua — find files faster than you can remember what you named them
- **Oil.nvim** file explorer — because netrw hurt us
- **Git** integration — Gitsigns, Neogit, Diffview, git-blame (for pointing fingers)
- **Debugging** with nvim-dap (Go, Python, Rust/C/C++) — `print()` debugging but fancier
- **Testing** with Neotest (Go, Python, Jest, Rust) — watch your tests fail in style
- **Treesitter** for syntax highlighting, textobjects, and context — rebuilt from scratch after the Great Rewrite of 2025
- **Snacks.nvim** dashboard — the first thing you see before spending 3 hours tweaking configs instead of writing code

## Structure

```
~/.config/nvim/
├── init.lua                    # The front door
├── lua/
│   ├── config/
│   │   ├── autocmds.lua        # Things that happen automatically
│   │   ├── keymaps.lua         # Your muscle memory, codified
│   │   ├── lazy.lua            # lazy.nvim bootstrap
│   │   └── options.lua         # Vim options (there are so many)
│   └── plugins/
│       ├── ai.lua              # Our robot overlords (Copilot + OpenCode)
│       ├── colorscheme.lua     # Rose Pine (the correct choice)
│       ├── completion.lua      # blink.cmp + LuaSnip
│       ├── dap.lua             # Debug adapters (for when print() isn't enough)
│       ├── dashboard.lua       # The LOSTNVIM splash screen
│       ├── editor.lua          # Editing enhancements you didn't know you needed
│       ├── explorer.lua        # Oil.nvim (RIP netrw)
│       ├── finder.lua          # fzf-lua (find all the things)
│       ├── git.lua             # Git tools (for blaming coworkers)
│       ├── lsp.lua             # LSP, Mason, formatters, linters (the big one)
│       ├── misc.lua            # Discord presence, scrolling, etc.
│       ├── terminal.lua        # Toggleterm + Flatten
│       ├── test.lua            # Neotest (optimism.lua)
│       ├── treesitter.lua      # Treesitter + textobjects
│       └── ui.lua              # Lualine, which-key, pretty things
├── .luarc.json                 # Lua LSP project settings
├── .stylua.toml                # StyLua formatter config
└── selene.toml                 # Selene linter config
```

## Languages

Full LSP, formatting, linting, debugging, and testing support where applicable. "Full" is doing some heavy lifting in that sentence.

| Language | LSP | Formatter | Linter | Debug | Test |
|----------|-----|-----------|--------|-------|------|
| Lua | `lua_ls` | `stylua` | `selene` | | |
| Python | `basedpyright` | `ruff` | `ruff` | `debugpy` | `pytest` |
| TypeScript/JS | `ts_ls` | `prettierd` | `eslint_d` | | `jest` |
| Go | `gopls` | `goimports` + `gofumpt` | `golangci-lint` | `delve` | `neotest-golang` |
| Rust | `rust_analyzer` | `rustfmt` | | `codelldb` | `rustaceanvim` |
| C/C++ | `clangd` | `clang-format` | | `codelldb` | |
| Bash | `bashls` | `shfmt` | `shellcheck` | | |
| HTML | `html` + `emmet_ls` | `prettierd` | | | |
| CSS | `cssls` + `tailwindcss` | `prettierd` | | | |
| JSON | `jsonls` | `prettierd` | | | |
| YAML | `yamlls` | `prettierd` | | | |
| TOML | `taplo` | `taplo` | | | |
| SQL | `sqls` | `sql_formatter` | | | |
| Markdown | `marksman` | `prettierd` | `markdownlint` | | |
| Docker | `dockerls` | | `hadolint` | | |

## Keymaps

Leader key is `Space`. Local leader is `,`. If you forget a keymap, press `Space` and wait — which-key will save you.

### General

| Key | Mode | Action |
|-----|------|--------|
| `<Esc>` | n | Clear search highlights |
| `<C-s>` | n, i, x | Save file |
| `jk` | i | Escape insert mode |
| `<A-j>` / `<A-k>` | n, i, v | Move lines down / up |
| `<` / `>` | v | Indent and stay in visual mode |
| `p` | x | Paste without yanking |
| `Y` | n | Yank to end of line |
| `<C-d>` / `<C-u>` | n | Scroll down / up (centered) |
| `<leader>a` | n | Select all |

### Navigation

| Key | Mode | Action |
|-----|------|--------|
| `<C-h/j/k/l>` | n, t | Navigate windows |
| `<C-Arrow>` | n | Resize windows |
| `<S-h>` / `<S-l>` | n | Previous / next buffer |
| `<leader>bb` | n | Alternate buffer |
| `<leader>bd` | n | Delete buffer |
| `<leader>bo` | n | Delete other buffers |
| `<leader>-` | n | Horizontal split |
| `<leader>\|` | n | Vertical split |

### Finding (fzf-lua)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>ff` | n | Find files |
| `<leader>fg` | n | Live grep |
| `<leader>fb` | n | Buffers |
| `<leader>fh` | n | Help tags |
| `<leader>fr` | n | Recent files |
| `<leader>fw` | n | Grep word under cursor |
| `<leader>fs` | n | Document symbols |
| `<leader>fS` | n | Workspace symbols |
| `<leader>fd` | n | Diagnostics |
| `<leader>fc` | n | Config files |
| `<leader>fR` | n | Resume last picker |
| `<leader>f/` | n | Grep open buffers |

### LSP

| Key | Mode | Action |
|-----|------|--------|
| `gd` | n | Go to definition |
| `gr` | n | References |
| `gI` | n | Go to implementation |
| `gy` | n | Go to type definition |
| `gD` | n | Go to declaration |
| `K` | n | Hover documentation |
| `gK` | n | Signature help |
| `<leader>la` | n, v | Code actions |
| `<leader>lr` | n | Rename symbol |
| `<leader>lf` | n, v | Format buffer |
| `<leader>ld` | n | Document diagnostics |
| `<leader>lD` | n | Workspace diagnostics |
| `<leader>ls` | n | Document symbols |
| `<leader>lS` | n | Workspace symbols |
| `<leader>li` | n | LSP info |
| `<leader>lR` | n | LSP restart |
| `<leader>lh` | n | Toggle inlay hints |
| `<leader>lm` | n | Mason |
| `]d` / `[d` | n | Next / previous diagnostic |
| `<leader>cd` | n | Line diagnostics (float) |

### Git

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gg` | n | Neogit |
| `<leader>gd` | n | Diffview open |
| `<leader>gD` | n | Diffview close |
| `<leader>gb` | n | Git blame line |
| `<leader>gB` | n | Toggle git blame |
| `<leader>gs` | n | Stage hunk |
| `<leader>gr` | n | Reset hunk |
| `<leader>gS` | n | Stage buffer |
| `<leader>gR` | n | Reset buffer |
| `<leader>gp` | n | Preview hunk |
| `<leader>gh` | n | Diffview file history |
| `]h` / `[h` | n | Next / previous hunk |

### Debug

| Key | Mode | Action |
|-----|------|--------|
| `<leader>db` | n | Toggle breakpoint |
| `<leader>dB` | n | Conditional breakpoint |
| `<leader>dc` | n | Continue |
| `<leader>di` | n | Step into |
| `<leader>do` | n | Step over |
| `<leader>dO` | n | Step out |
| `<leader>dt` | n | Terminate |
| `<leader>du` | n | Toggle DAP UI |
| `<leader>de` | n, v | Eval expression |
| `<leader>dl` | n | Run last |

### Test (Neotest)

| Key | Mode | Action |
|-----|------|--------|
| `<leader>tn` | n | Run nearest test |
| `<leader>tf` | n | Run file tests |
| `<leader>ts` | n | Test suite |
| `<leader>tl` | n | Run last test |
| `<leader>to` | n | Toggle test output panel |
| `<leader>tS` | n | Toggle test summary |

### AI

| Key | Mode | Action |
|-----|------|--------|
| `<C-l>` | i | Accept Copilot suggestion |
| `<M-]>` / `<M-[>` | i | Next / previous suggestion |
| `<C-]>` | i | Dismiss suggestion |
| `<C-.>` | n, t | Toggle OpenCode terminal |
| `<leader>oa` | n, x | Ask OpenCode |
| `<leader>os` | n, x | OpenCode action picker |
| `<leader>oo` | n, x | OpenCode operator |

### Other

| Key | Mode | Action |
|-----|------|--------|
| `<leader>e` | n | Oil file explorer |
| `<leader>tt` | n | Toggle terminal |
| `<leader>u` | n | Undotree |
| `<leader>xx` | n | Trouble diagnostics |
| `<leader>xd` | n | Trouble buffer diagnostics |
| `<leader>sr` | n | Search and replace (grug-far) |
| `s` | n, x, o | Flash jump |
| `<leader>L` | n | Lazy plugin manager |
| `<leader>D` | n | Database UI |
| `<leader>qq` | n | Quit all |

## Plugins

<details>
<summary>Full plugin list (~65 plugins) — yes, we counted</summary>

### Colorscheme
- [rose-pine/neovim](https://github.com/rose-pine/neovim) — Rose Pine (Moon variant)

### UI
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) — Statusline
- [which-key.nvim](https://github.com/folke/which-key.nvim) — Keybinding hints (because we can't remember 200 keymaps)
- [mini.icons](https://github.com/echasnovski/mini.icons) — Icon provider
- [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) — Indent guides
- [mini.indentscope](https://github.com/echasnovski/mini.indentscope) — Animated scope indicator
- [nvim-scrollbar](https://github.com/petertriho/nvim-scrollbar) — Scrollbar with diagnostic marks
- [nvim-highlight-colors](https://github.com/brenoprata10/nvim-highlight-colors) — Inline color previews
- [smartcolumn.nvim](https://github.com/m4xshen/smartcolumn.nvim) — Smart colorcolumn
- [fidget.nvim](https://github.com/j-hui/fidget.nvim) — LSP progress / notifications
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) — File icons
- [snacks.nvim](https://github.com/folke/snacks.nvim) — Dashboard, input, picker, terminal

### Editor
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) — Auto bracket pairing
- [mini.surround](https://github.com/echasnovski/mini.surround) — Surround operations
- [mini.ai](https://github.com/echasnovski/mini.ai) — Extended text objects
- [mini.bracketed](https://github.com/echasnovski/mini.bracketed) — Bracket navigation
- [flash.nvim](https://github.com/folke/flash.nvim) — Jump / motion
- [vim-matchup](https://github.com/andymass/vim-matchup) — Extended `%` matching
- [undotree](https://github.com/mbbill/undotree) — Undo history visualizer
- [yanky.nvim](https://github.com/gbprod/yanky.nvim) — Yank ring
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) — Highlighted TODO comments
- [dial.nvim](https://github.com/monaqa/dial.nvim) — Enhanced increment / decrement
- [rainbow-delimiters.nvim](https://github.com/HiPhish/rainbow-delimiters.nvim) — Rainbow brackets
- [refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim) — Refactoring operations

### Completion
- [blink.cmp](https://github.com/saghen/blink.cmp) — Autocompletion engine
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip) — Snippet engine
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) — Snippet collection

### LSP & Tooling
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) — LSP server defaults (we use native `vim.lsp.config()` now, like adults)
- [mason.nvim](https://github.com/williamboman/mason.nvim) — Tool installer
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) — Mason + LSP bridge (auto-enables servers)
- [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) — Auto-install formatters/linters
- [conform.nvim](https://github.com/stevearc/conform.nvim) — Formatter
- [nvim-lint](https://github.com/mfussenegger/nvim-lint) — Linter
- [trouble.nvim](https://github.com/folke/trouble.nvim) — Diagnostics list
- [tiny-inline-diagnostic.nvim](https://github.com/rachartier/tiny-inline-diagnostic.nvim) — Inline diagnostics
- [inc-rename.nvim](https://github.com/smjonas/inc-rename.nvim) — Live rename preview
- [actions-preview.nvim](https://github.com/aznhe21/actions-preview.nvim) — Code action preview
- [nvim-lsp-file-operations](https://github.com/antosha417/nvim-lsp-file-operations) — LSP-aware file ops
- [garbage-day.nvim](https://github.com/zeioth/garbage-day.nvim) — Auto-stop idle LSP servers
- [nvim-lsp-endhints](https://github.com/chrisgrieser/nvim-lsp-endhints) — End-of-line inlay hints
- [lazydev.nvim](https://github.com/folke/lazydev.nvim) — Lua dev for Neovim config
- [schemastore.nvim](https://github.com/b0o/schemastore.nvim) — JSON/YAML schemas

### Language-specific
- [rustaceanvim](https://github.com/mrcjkb/rustaceanvim) — Rust tooling
- [clangd_extensions.nvim](https://github.com/p00f/clangd_extensions.nvim) — C/C++ extras
- [crates.nvim](https://github.com/Saecki/crates.nvim) — Cargo.toml management
- [gopher.nvim](https://github.com/olexsmir/gopher.nvim) — Go tooling
- [venv-selector.nvim](https://github.com/linux-cultist/venv-selector.nvim) — Python venv picker
- [vim-dadbod](https://github.com/tpope/vim-dadbod) + [UI](https://github.com/kristijanhusak/vim-dadbod-ui) — SQL/database client
- [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) — Markdown rendering

### Finder & Explorer
- [fzf-lua](https://github.com/ibhagwan/fzf-lua) — Fuzzy finder
- [oil.nvim](https://github.com/stevearc/oil.nvim) — File explorer

### Git
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) — Git signs + hunk actions
- [neogit](https://github.com/NeogitOrg/neogit) — Magit-style Git client
- [diffview.nvim](https://github.com/sindrets/diffview.nvim) — Diff viewer
- [git-blame.nvim](https://github.com/f-person/git-blame.nvim) — Inline blame

### Debug
- [nvim-dap](https://github.com/mfussenegger/nvim-dap) — Debug adapter protocol
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) — DAP UI
- [nvim-dap-virtual-text](https://github.com/theHamsta/nvim-dap-virtual-text) — Inline debug values
- [persistent-breakpoints.nvim](https://github.com/Weissle/persistent-breakpoints.nvim) — Saved breakpoints
- [mason-nvim-dap.nvim](https://github.com/jay-babu/mason-nvim-dap.nvim) — Mason + DAP bridge
- [nvim-dap-go](https://github.com/leoluz/nvim-dap-go) — Go debug adapter
- [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) — Python debug adapter

### Test
- [neotest](https://github.com/nvim-neotest/neotest) — Test runner framework
- [neotest-golang](https://github.com/fredrikaverpil/neotest-golang) — Go adapter
- [neotest-python](https://github.com/nvim-neotest/neotest-python) — Python adapter
- [neotest-jest](https://github.com/nvim-neotest/neotest-jest) — Jest adapter

### Terminal
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) — Terminal manager
- [flatten.nvim](https://github.com/willothy/flatten.nvim) — Nested Neovim handling

### AI
- [copilot.lua](https://github.com/zbirenbaum/copilot.lua) — GitHub Copilot
- [blink-cmp-copilot](https://github.com/giuxtaposition/blink-cmp-copilot) — Copilot source for blink.cmp
- [opencode.nvim](https://github.com/nickjvandyke/opencode.nvim) — OpenCode integration

### Misc
- [presence.nvim](https://github.com/andweeb/presence.nvim) — Discord Rich Presence (so people know you use Neovim)
- [neoscroll.nvim](https://github.com/karb94/neoscroll.nvim) — Smooth scrolling
- [auto-save.nvim](https://github.com/okuuva/auto-save.nvim) — Auto-save (trust issues with `:w`)
- [persistence.nvim](https://github.com/folke/persistence.nvim) — Session management
- [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) — Search and replace
- [nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens) — Search lens
- [project.nvim](https://github.com/coffebar/project.nvim) — Project management
- [guess-indent.nvim](https://github.com/NMAC427/guess-indent.nvim) — Auto-detect indentation
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) — Lua utilities
- [nvim-nio](https://github.com/nvim-neotest/nvim-nio) — Async IO
- [sqlite.lua](https://github.com/kkharji/sqlite.lua) — SQLite bindings

</details>

## Requirements

- **Neovim** >= 0.11 (we use the shiny new native LSP API)
- **Git** >= 2.19
- A [Nerd Font](https://www.nerdfonts.com/) (the icons won't draw themselves)
- **ripgrep** (`rg`) — for grep
- **fzf** — for fzf-lua
- **fd** — for file finding
- **node** — for some LSP servers
- **opencode** CLI — optional, for OpenCode AI ([install](https://opencode.ai))

## Install

Back up your existing config (you do have backups, right?), then clone:

```bash
# Backup (you'll thank yourself later)
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak

# Clone
git clone https://github.com/TheAK12/lostnvim.git ~/.config/nvim
```

Launch Neovim. lazy.nvim will bootstrap itself, install all plugins, and Mason will install LSP servers, formatters, and linters automatically. Go make coffee — or don't, it's actually pretty fast.

```bash
nvim
```

Run `:checkhealth` to verify everything is set up correctly. Fix any warnings. Question your life choices. Continue editing.

## FAQ

**Q: Why not just use VS Code?**
A: We don't do that here.

**Q: How many hours did this take to configure?**
A: Time is a flat circle.

**Q: Can I use this config?**
A: Yes. Fork it, clone it, break it, fix it, make it yours. That's the Neovim way.

**Q: Something broke after an update.**
A: Welcome to the Neovim ecosystem. Run `:Lazy update`, `:MasonToolsUpdate`, and `:TSUpdate`. If that doesn't work, check the plugin's GitHub issues. If *that* doesn't work, `git blame` and send a strongly worded commit message.

## License

Do whatever you want with it. Seriously. If this config helps you, great. If it ruins your afternoon, also great — suffering builds character.

MIT, if you need something official.
