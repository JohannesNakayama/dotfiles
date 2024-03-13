-- ============================================================================
-- === PLUGINS ================================================================
-- ============================================================================

-- Make sure that packer is installed and if not, install it
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system(
      {
        'git', 'clone',
        '--depth', '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
      }
    )
    vim.cmd [[ packadd packer.nvim ]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Manage plugins
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'folke/tokyonight.nvim'
  use 'catppuccin/nvim'
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    requires = 'nvim-lua/plenary.nvim',
  }
  use {
    'akinsho/bufferline.nvim',
    tag = '*',
    requires = 'nvim-tree/nvim-web-devicons',
  }
  use 'junegunn/goyo.vim'
  use 'mg979/vim-visual-multi'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'stevearc/dressing.nvim'
  use 'tpope/vim-commentary'
  use 'farmergreg/vim-lastplace'
  use 'JuliaEditorSupport/julia-vim'

  -- Completion/Snippets
  use {
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    {
      'L3MON4D3/LuaSnip',
      tag = 'v2.*',
      run = 'make install_jsregexp',
    },
  }

  -- Github Copilot
  use 'github/copilot.vim'

  -- LSP support
  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim', -- mason/lspconfig interface
    'neovim/nvim-lspconfig',
  } 

  -- Linting/Formatting
  use {
    'mfussenegger/nvim-lint',
    'mhartington/formatter.nvim',
    'MunifTanjim/prettier.nvim',
  }

  -- Refactoring
  use 'smjonas/inc-rename.nvim'
  use 'AndrewRadev/splitjoin.vim'

  -- Integration with tmux
  use { 'christoomey/vim-tmux-navigator' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
