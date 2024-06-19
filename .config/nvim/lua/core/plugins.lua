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
  use 'nvim-treesitter/nvim-treesitter'
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    requires = 'nvim-lua/plenary.nvim',
    opts = {
      pickers = {
        find_files = {
          -- hidden = true, -- will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" }, -- use ripgrep, find hidden files and folders except .git/
        },
        live_grep = {
          additional_args = { "--hidden", "--glob", "!**/.git/*" }, -- search in hidden files and folders except .git/
        },
      },
    }
  }

  use 'nvim-lualine/lualine.nvim'
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

  use 'folke/which-key.nvim'

  use 'kylechui/nvim-surround'

  use {
    'NvChad/nvim-colorizer.lua',
    -- highlight color codes in files
    -- demo colors: #8BF8E7, salmon
    lazy = false,
    config = function()
      require("colorizer").setup({
      })
    end
  }

  -- Github Copilot
  use {
    'github/copilot.vim',
    suggestion = {
      keymap = {
        accept_word = "<C-w>",
      } ,
    },
  }

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

  -- Automatically create directories when opening a non-existent file with vim
  use { 'arp242/auto_mkdir2.vim' }

  -- Switch between certain defined patterns (e.g. true <-> false)
  use { 'AndrewRadev/switch.vim' }


  use { 'gioele/vim-autoswap' }
  use { 'lewis6991/gitsigns.nvim' }

  use {
    'nvimtools/none-ls.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      local null_ls = require("null-ls")
      local sources = {
        null_ls.builtins.formatting.alejandra, -- nix formatter
      }
      null_ls.setup()
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
