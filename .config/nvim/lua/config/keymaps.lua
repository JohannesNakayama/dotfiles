-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- l/L: next/prev buffer
-- L was: place cursor at bottom of screen
-- --> https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L34
vim.keymap.set("n", "l", ":bnext<CR>")
vim.keymap.set("v", "l", ":bnext<CR>")
vim.keymap.set("n", "L", ":bprev<CR>")
vim.keymap.set("v", "L", ":bprev<CR>")

vim.keymap.set("n", "ö", ":update<CR>")
vim.keymap.set("v", "ö", "<esc>:update<CR>gv")
vim.keymap.set("n", "ä", ":q<CR>")
vim.keymap.set("v", "ä", "<esc>:q<CR>")
vim.keymap.set("n", "ü", ":bd<CR>")
vim.keymap.set("v", "ü", "<esc>:q<CR>")
