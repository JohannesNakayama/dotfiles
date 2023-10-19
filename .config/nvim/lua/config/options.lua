-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.breakindent = true
vim.opt.breakindentopt = { shift = 2 }
vim.opt.wrap = true
vim.opt.linebreak = true

vim.opt.guifont = { "RobotoMono Nerd Font", ":h8" }

vim.g.goyo_width = "60%"

if vim.g.neovide then
  vim.g.neovide_scroll_animation_length = 0.5
  vim.g.neovide_touch_drag_timeout = 0.17
  vim.g.neovide_cursor_animation_length = 0.13
end
