-- ============================================================================
-- === PLUGINS ================================================================
-- ============================================================================

-- --- Install Lazy -----------------------------------------------------------

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

-- --- Define Plugins ---------------------------------------------------------

require("lazy").setup({
  -- Colorschemes
  'folke/tokyonight.nvim',
  'catppuccin/nvim',

  -- File tree
  {
    'nvim-tree/nvim-tree.lua',
    keys = {
      { '<leader>e', ':NvimTreeFindFileToggle<cr>', desc = 'Toggle nvim-tree' },
      { '<leader>tf', ':NvimTreeFocus<cr>', desc = 'Focus nvim-tree' },
    }
  },

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

  -- Fuzzy find files
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- Julia plugin
  'JuliaEditorSupport/julia-vim',

  -- Zen mode
  "folke/zen-mode.nvim",

  -- Highlight color codes in files
  -- demo colors: #8BF8E7, salmon
  'NvChad/nvim-colorizer.lua',

  {
    'axkirillov/easypick.nvim',
    dependencies = 'nvim-telescope/telescope.nvim',
    keys = {
      { "<leader>vd", ":Easypick dotfiles<cr>", desc = "Dotfiles" },
    },
  },

  -- Github Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
  },

  -- Copilot integration with cmp
  'zbirenbaum/copilot-cmp',

  -- Linting/Formatting
  'mfussenegger/nvim-lint',
  'mhartington/formatter.nvim',
  'MunifTanjim/prettier.nvim',

  -- LSP support
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim', -- mason/lspconfig interface
  'neovim/nvim-lspconfig',

  -- Completion/Snippets
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
  },

  -- Refactoring
  {
    'smjonas/inc-rename.nvim',
    keys = {
      {
        '<leader>cr',
        function() return ':IncRename ' .. vim.fn.expand('<cword>') end,
        desc = 'LSP rename action',
      },
    },
  },

  'AndrewRadev/splitjoin.vim',

  -- Automatically create directories when opening a non-existent file with vim
  'arp242/auto_mkdir2.vim',

  -- Switch between certain defined patterns (e.g. true <-> false)
  {
    'AndrewRadev/switch.vim',
    keys = {
      { 'gs', desc = 'Switch true/false etc.' }
    },
    config = function()
      vim.g.switch_custom_definitions = {
        { "on",         "off" },
        { "==",         "!=" },
        { " < ",        " > " },
        { "<=",         ">=" },
        { " + ",        " - " },
        { "-=",         "+=" },
        { "and",        "or" },
        { "YES",        "NO" },
        { "yes",        "no" },
        { "first",      "last" },
        { "max",        "min" },
        { "left",       "right" },
        { "top",        "bottom" },
        { "margin",     "padding" },
        { "height",     "width" },
        { "absolute",   "relative" },
        { "show",       "hide" },
        { "visible",    "hidden" },
        { "add",        "remove" },
        { "up",         "down" },
        { "before",     "after" },
        { "inside",     "outside" },
      }
    end,
  },

  -- Handle swap file issues when opening the same file in two buffers
  'gioele/vim-autoswap',
})





-- --- TODO --------------------------------------------------------------------

-- TODO:
-- -- FIGURE OUT THE FOLLOWING CONFIGURATIONS

-- -- LSP none-ls
-- {
--   'nvimtools/none-ls.nvim',
--   dependencies = 'nvim-lua/plenary.nvim',
--   config = function()
--     local null_ls = require("null-ls")

--     local sources = {
--       null_ls.builtins.formatting.alejandra, -- nix formatter
--     }
--     null_ls.setup()
--   end,
-- },

-- {
--   "dundalek/lazy-lsp.nvim",
--   dependencies = {
--     "neovim/nvim-lspconfig",
--     { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
--     "hrsh7th/cmp-nvim-lsp",
--     "hrsh7th/nvim-cmp",
--   },
--   config = function()
--     local lsp_zero = require("lsp-zero")

--     lsp_zero.on_attach(function(client, bufnr)
--       -- see :help lsp-zero-keybindings to learn the available actions
--       lsp_zero.default_keymaps({
--         buffer = bufnr,
--         preserve_mappings = false
--       })
--     end)

--     -- completion menu
--     local cmp = require('cmp')
--     local cmp_mapping = require('cmp.config.mapping')
--     cmp.setup {
--       mapping = cmp_mapping.preset.insert {
--         ['<C-Space>'] = cmp.mapping.complete(),
--         ['<CR>'] = cmp.mapping.confirm({ select = true }),
--         ['<tab>'] = cmp.mapping.confirm({ select = true }),
--       },
--     }


--     -- format on save
--     -- TODO: toggle with keybinding
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       pattern = { "*" },
--       callback = function()
--         if vim.bo.filetype ~= "json" then
--           vim.lsp.buf.format({
--             async = false,
--             filter = function(client) return client.name ~= "tsserver" end
--           })
--         end
--       end,
--     })

--     require("lazy-lsp").setup {
--       excluded_servers = {
--         "denols", "quick_lint_js", "pylyzer", "marksman", "ltex"
--       },
--       -- Override config for specific servers that will passed down to lspconfig setup.
--       -- Note that the default_config will be merged with this specific configuration so you don't need to specify everything twice.
--       configs = {
--         eslint = {
--           on_attach = function(client, bufnr)
--             vim.api.nvim_create_autocmd("BufWritePre", {
--               buffer = bufnr,
--               command = "EslintFixAll",
--             })
--           end,
--         },
--         lua_ls = {
--           settings = {
--             Lua = {
--               diagnostics = {
--                 -- Get the language server to recognize the `vim` global
--                 globals = { "vim" },
--               },
--             },
--           },
--         },
--         rust_analyzer = {
--           settings = {
--             ["rust-analyzer"] = {
--               procMacro = {
--                 enable = true,
--               },
--               check = {
--                 command = "clippy",
--               },
--               cargo = {
--                 -- To prevent rustanalyzer from locking the target dir (blocking cargo build/run)
--                 -- https://github.com/rust-lang/rust-analyzer/issues/6007#issuecomment-1523204067
--                 extraEnv = { CARGO_PROFILE_RUST_ANALYZER_INHERITS = 'dev', },
--                 extraArgs = { "--profile", "rust-analyzer", },
--                 allFeatures = true,          -- enable all features, so that all optional dependencies are loaded
--                 loadOutDirsFromCheck = true, -- everybody seems to enable this
--               },
--               diagnostics = {
--                 -- show code, even if disabled via feature flags
--                 disabled = { "inactive-code" },
--               },
--             },
--           },
--         },
--       },
--     }
--   end,
-- },

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
-- --   'christoomey/vim-tmux-navigator'



-- TODO:
-- -- none-ls setup (following snippet is previous config)

-- local null_ls = require("null-ls")

-- null_ls.setup {
--   sources = {
--     null_ls.builtins.formatting.alejandra, -- nix formatter
--   }
-- }
