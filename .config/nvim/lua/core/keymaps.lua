-- ============================================================================
-- === KEY MAPPINGS ===========================================================
-- ============================================================================

-- l/L: next/prev buffer
-- L was: place cursor at bottom of screen
-- --> https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L34
vim.keymap.set('n', 'l', ':bnext<CR>')
vim.keymap.set('v', 'l', ':bnext<CR>')
vim.keymap.set('n', 'L', ':bprev<CR>')
vim.keymap.set('v', 'L', ':bprev<CR>')

-- Efficient one-button save/close bindings for neo2 layout
-- --> https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L41
vim.keymap.set('n', 'ö', ':update<CR>')
vim.keymap.set('v', 'ö', '<esc>:update<CR>gv')
vim.keymap.set('n', 'ä', ':q<CR>')
vim.keymap.set('v', 'ä', '<esc>:q<CR>')
vim.keymap.set('n', 'ü', ':bd<CR>')
vim.keymap.set('v', 'ü', '<esc>:q<CR>')

-- Source/edit nvim config
-- --> https://learnvimscriptthehardway.stevelosh.com/chapters/07.html
-- --> https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L135
vim.keymap.set('n', '<leader>sv', ':luafile $MYVIMRC<CR>')
vim.keymap.set('v', '<leader>sv', ':luafile $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>vv', ':e $MYVIMRC<CR>')

-- Don't lose selection when indenting //<- fdietze/dotfiles
-- --> https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L104
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '=', '=gv')

-- Highlight off after search
vim.keymap.set('n', '<leader>h', ':nohl<CR>')

vim.keymap.set({'n', 'v', 'i'}, '<c-m-i>', '<cmd> TmuxNavigateLeft<cr>')
vim.keymap.set({'n', 'v', 'i'}, '<c-m-e>', '<cmd> TmuxNavigateRight<cr>')
vim.keymap.set({'n', 'v', 'i'}, '<c-m-l>', '<cmd> TmuxNavigateUp<cr>')
vim.keymap.set({'n', 'v', 'i'}, '<c-m-a>', '<cmd> TmuxNavigateDown<cr>')
