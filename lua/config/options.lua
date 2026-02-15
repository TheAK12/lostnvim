-- ── Options ──────────────────────────────────────────────────

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Cursor
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.shiftround = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.wrap = false
opt.showmode = false
opt.conceallevel = 2
opt.pumheight = 10
opt.pumblend = 10
opt.winblend = 0
opt.cmdheight = 1
opt.laststatus = 3 -- Global statusline

-- Fill characters
opt.fillchars = {
  foldopen = "v",
  foldclose = ">",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

-- Persistence
opt.undofile = true
opt.undolevels = 10000
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- Clipboard
opt.clipboard = "unnamedplus"

-- Mouse
opt.mouse = "a"

-- Performance
opt.updatetime = 200
opt.timeoutlen = 300
opt.redrawtime = 1500
opt.lazyredraw = false

-- Completion
opt.completeopt = "menu,menuone,noselect"
opt.shortmess:append { W = true, I = true, c = true, C = true }

-- Grep
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- Sessions
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- Misc
opt.confirm = true
opt.inccommand = "nosplit" -- Live preview for :s
opt.virtualedit = "block" -- Allow cursor past end in visual block
opt.formatoptions = "jcroqlnt"
opt.jumpoptions = "view"
opt.linebreak = true -- Wrap at word boundaries (when wrap is on)
opt.spelllang = { "en" }

-- Smooth scrolling (Neovim 0.10+)
if vim.fn.has "nvim-0.10" == 1 then
  opt.smoothscroll = true
end

-- Disable unused providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
