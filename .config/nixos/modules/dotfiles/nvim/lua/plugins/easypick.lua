return {
	{
		"axkirillov/easypick.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		keys = {
			{ "<leader>vd", ":Easypick dotfiles<cr>", desc = "Fuzzy search dotfiles" },
		},
		opts = function()
			local easypick = require("easypick")
			return {
				pickers = {
					{
						name = "dotfiles",
						command = 'cfg ls-tree --full-tree --name-only -r HEAD | sed "s|^|~/|"',
						previewer = easypick.previewers.default(),
					},
				},
			}
		end,
	},
}
