-- ╔══════════════════════════════════════════════════════════╗
-- ║                       LostNvim                          ║
-- ╚══════════════════════════════════════════════════════════╝

-- Set leader keys before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Bootstrap lazy.nvim and load plugins
require "config.lazy"

-- Load core configuration
require "config.options"
require "config.keymaps"
require "config.autocmds"
