-- ============================================================================
-- === NEOVIM CONFIG ==========================================================
-- ============================================================================

require("core.options")
require("config.lazy")
require("lazy").setup("plugins")
require("config.lsp")
require("core.keymaps")

-- available colorschemes: tokyonight, paper, catppuccin
vim.cmd [[ colorscheme catppuccin ]]
