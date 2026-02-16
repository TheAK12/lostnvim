-- ── Keymaps ──────────────────────────────────────────────────

local map = vim.keymap.set

-- ── General ──────────────────────────────────────────────────

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Save file
map({ "n", "i", "x", "s" }, "<C-s>", "<cmd>w<CR><Esc>", { desc = "Save file" })

-- Quit
map("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit all" })

-- Better escape
map("i", "jk", "<Esc>", { desc = "Escape insert mode" })

-- Better up/down (respects wrapped lines)
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move line up" })
map("i", "<A-j>", "<Esc><cmd>m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<Esc><cmd>m .-2<CR>==gi", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })

-- Better indenting (stay in visual mode)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- ── Windows ──────────────────────────────────────────────────

map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize with arrows
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- Splits
map("n", "<leader>-", "<cmd>split<CR>", { desc = "Horizontal split" })
map("n", "<leader>|", "<cmd>vsplit<CR>", { desc = "Vertical split" })

-- ── Buffers ──────────────────────────────────────────────────

map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map("n", "<leader>bo", "<cmd>%bdelete|edit#|bdelete#<CR>", { desc = "Delete other buffers" })
map("n", "<leader>bb", "<cmd>e #<CR>", { desc = "Switch to alternate buffer" })

-- ── Diagnostics ──────────────────────────────────────────────

map("n", "]d", function() vim.diagnostic.jump { count = 1 } end, { desc = "Next diagnostic" })
map("n", "[d", function() vim.diagnostic.jump { count = -1 } end, { desc = "Previous diagnostic" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- ── Misc ─────────────────────────────────────────────────────

-- New file
map("n", "<leader>fn", "<cmd>enew<CR>", { desc = "New file" })

-- Lazy
map("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "Lazy" })

-- Select all
map("n", "<leader>a", "ggVG", { desc = "Select all" })

-- Note: <C-d>/<C-u> scroll handled by neoscroll (plugins/misc.lua)

-- Don't yank on paste in visual mode
map("x", "p", [["_dP]], { desc = "Paste without yanking" })

-- Yank to end of line (consistent with C, D)
map("n", "Y", "y$", { desc = "Yank to end of line" })

-- Terminal escape
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Go to right window" })
