-- ============================================================================
-- === OPITONS ================================================================
-- ============================================================================

-- Leader settings
vim.g.mapleader = " "
vim.g.maplocalleader = "_"

-- Wrapping, indentation, and line breaks
vim.opt.wrap = true -- wrap long lines
vim.opt.linebreak = true -- break wrapped lines at words
vim.opt.breakindent = true -- maintain indentation level for wrapped lines
vim.opt.breakindentopt = { shift = 2 } -- add extra 2-space indentation to wrapped lines
vim.opt.list = true -- show invisible characters
vim.opt.listchars = { tab = "·-", trail = "·" } -- define how invisible characters are shown
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true -- convert tabs into spaces

-- Search settings
vim.opt.ignorecase = true -- case-insensitive search
vim.opt.smartcase = true -- override ignorecase if capital letter is typed
vim.opt.hls = true -- keep search results highlighted

-- Disable unnecessary default functionality
vim.g.loaded_netrw = 1 -- disable built-in file explorer (not needed because of nvim-tree)
vim.g.loaded_netrwPlugin = 1
vim.g.minipairs_disable = true -- disable automatic pairing (for parens, quotes, etc.)

-- Other settings
vim.opt.clipboard = "unnamedplus" -- share system clipboard
vim.opt.gdefault = true -- omit `/g` flag in replacement commands
vim.opt.undofile = true -- persistent undo file (undo even after file closed and re-opened)
vim.opt.history = 10000 -- remember last 10000 commands

-- IDE settings
vim.opt.guifont = { "RobotoMono Nerd Font", ":h8" }
vim.opt.termguicolors = true -- enable 24-bit RGB colors
vim.opt.showcmd = false -- don't show command in bottom right corner
vim.opt.cursorline = true -- highlight line where cursor is currently located
vim.opt.laststatus = 3 -- one status line per neovim instance (also with multiple windows)
vim.opt.number = true -- show line numbers on left side
vim.opt.startofline = false -- keep cursor at current vertical position when navigating up and down
vim.opt.confirm = true -- ask to save changes when exiting unsaved work
