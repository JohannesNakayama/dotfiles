return {
	"nvim-tree/nvim-web-devicons", -- icons
	{
		"nvim-tree/nvim-tree.lua",
		keys = {
			{ "<leader>e", ":NvimTreeFindFileToggle<cr>", desc = "Toggle nvim-tree" },
			{ "<leader>tf", ":NvimTreeFocus<cr>", desc = "Focus nvim-tree" },
		},
		opts = {
			git = {
				enable = true,
				ignore = false,
				timeout = 500,
			},
			view = {
				side = "right",
				width = 80,
			},
		},
	},
}
