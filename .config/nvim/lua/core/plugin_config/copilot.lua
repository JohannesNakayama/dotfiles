-- Toggle copilot
vim.keymap.set('n', '<leader>ai', ':Copilot enable<CR>')
vim.keymap.set('v', '<leader>ai', ':Copilot enable<CR>')
vim.keymap.set('n', '<leader>nai', ':Copilot disable<CR>')
vim.keymap.set('v', '<leader>nai', ':Copilot disable<CR>')

-- Open suggestions panel
vim.keymap.set('n', '<leader>aip', ':Copilot panel<CR>')
