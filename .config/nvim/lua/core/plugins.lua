-- ============================================================================
-- === PLUGINS ================================================================
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Colorschemes
  {
    'folke/tokyonight.nvim',
    opts = {
      transparent = true,
      styles = {
         sidebars = "transparent",
         floats = "transparent",
      },
    },
  },
  'catppuccin/nvim',

  -- File tree
  'nvim-tree/nvim-tree.lua',

  -- Status and buffer lines
  'nvim-lualine/lualine.nvim',
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
  },

  -- Icons
  'nvim-tree/nvim-web-devicons',

  -- Show git status information on buffers
  'lewis6991/gitsigns.nvim',

  -- Fuzzy find files
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      pickers = {
        find_files = {
          -- use ripgrep, find hidden files and folders except .git/
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        live_grep = {
          -- search in hidden files and folders except .git/
          additional_args = { "--hidden", "--glob", "!**/.git/*" },
        },
      },
    }
  },

  -- Multiple cursors in visual mode
  'mg979/vim-visual-multi',

  -- Commenting
  'tpope/vim-commentary',

  -- Open file in same place where you left off last time
  'farmergreg/vim-lastplace',

  -- Indentation guides
  'lukas-reineke/indent-blankline.nvim',

  -- Nice UI
  'stevearc/dressing.nvim',

  -- Auto surround text with brackets, quotes, etc.
  'kylechui/nvim-surround',

  -- Highlight color codes in files
  {
    'NvChad/nvim-colorizer.lua',
    -- highlight color codes in files
    -- demo colors: #8BF8E7, salmon
    lazy = false,
    config = function()
      require("colorizer").setup({
      })
    end
  },

  -- Julia plugin
  'JuliaEditorSupport/julia-vim',

  -- Github Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<C-tab>",
          accept_word = "<C-t>",
          accept_line = false,
          next = "<C-n>",
          dismiss = "<C-,>",
        },
      },
      filetypes = {
        yaml = true,
        markdown = false,
        gitcommit = true,
        json = true,
      },
    },
  },

  -- LSP support
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim', -- mason/lspconfig interface
  'neovim/nvim-lspconfig',

  -- Linting/Formatting
  'mfussenegger/nvim-lint',
  'mhartington/formatter.nvim',
  'MunifTanjim/prettier.nvim',

  -- Refactoring
  'smjonas/inc-rename.nvim',
  'AndrewRadev/splitjoin.vim',

  -- Automatically create directories when opening a non-existent file with vim
  'arp242/auto_mkdir2.vim',

  -- Switch between certain defined patterns (e.g. true <-> false)
  'AndrewRadev/switch.vim',

  -- Automatically handle swap file issue when opening the same file in two buffers
  'gioele/vim-autoswap',

  -- LSP none-ls
  {
    'nvimtools/none-ls.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      local null_ls = require("null-ls")
      local sources = {
        null_ls.builtins.formatting.alejandra, -- nix formatter
      }
      null_ls.setup()
    end,
  },

  -- Zen mode
  "folke/zen-mode.nvim",

  -- {
  --   "folke/which-key.nvim",
  --   event = "VeryLazy",
  --   init = function()
  --     vim.o.timeout = true
  --     vim.o.timeoutlen = 300
  --   end,
  --   opts = {
  --     -- TODO:
  --     -- -- your configuration comes here
  --     -- -- or leave it empty to use the default settings
  --     -- -- refer to the configuration section below
  --   }
  -- },

  -- --   -- Integration with tmux
  -- --   use { 'christoomey/vim-tmux-navigator' }

  -- -- Completion/Snippets
  -- 'hrsh7th/nvim-cmp',
  -- 'hrsh7th/cmp-nvim-lsp',
  -- {
    -- 'L3MON4D3/LuaSnip',
    -- tag = 'v2.*',
    -- run = 'make install_jsregexp',
  -- },

})
