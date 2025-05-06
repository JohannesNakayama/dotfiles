-- ============================================================================
-- === OPITONS ================================================================
-- ============================================================================

-- Leader mappings
vim.g.mapleader = ' '
vim.g.maplocalleader = '_'

-- Use system clipboard
vim.o.clipboard = 'unnamedplus'

-- Disable automatic pairing (for parens, quotes, etc.)
vim.g.minipairs_disable = true

-- Set GUI font
vim.opt.guifont = { 'RobotoMono Nerd Font', ':h8' }

-- No autoformating on save by default
vim.g.autoformat = true

-- Sane defaults
vim.o.termguicolors = true
vim.o.showcmd = false
vim.o.cursorline = true
vim.o.laststatus = 2
vim.o.number = true
-- vim.o.updatetime = 100
vim.o.startofline = false
vim.o.confirm = true

-- Search options
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hls = true

-- Wrapping and indenting
vim.o.wrap = true
vim.opt.linebreak = true
vim.o.breakindent = true
vim.opt.breakindentopt = { shift = 2 }

-- Tabs/Shift
vim.opt.list = true
vim.opt.listchars = { tab = '⊳\\' , trail = '·', }
-- vim.opt.listchars = { tab = '│·', trail = '·', }
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true


-- TODO: describe (automatic g in s/../../g <-)
vim.opt.gdefault = true

vim.opt.undofile = true

vim.opt.history = 10000


-- Disable netrw (replaced by nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
