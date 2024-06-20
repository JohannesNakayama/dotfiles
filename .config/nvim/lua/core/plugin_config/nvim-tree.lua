vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
	git = {
		enable = true,
		ignore = false,
		timeout = 500,
	},
})

vim.keymap.set('n', '<leader>e', ':NvimTreeFindFileToggle<CR>')
vim.keymap.set('n', '<leader>tf', ':NvimTreeFocus<CR>')
