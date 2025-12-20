return {
  {
    "kylechui/nvim-surround",
    version = "^3.1.8", -- for stability
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({})
    end,
  },
}
