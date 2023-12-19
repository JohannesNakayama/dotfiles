-- NOTE:
-- It is important that mason and mason-lspconfig are setup before setting up
-- LSP servers with lspconfig.
require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = { 'tsserver', 'jsonls' },
}

-- Load capabilities of nvim-cmp to replace default nvim lsp capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Specify handlers for mason-lspconfig
require("mason-lspconfig").setup_handlers {
  -- Default handler that will be called if no other config is specified
  function (server_name)
    require("lspconfig")[server_name].setup {
      capabilities = capabilities,
    }
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  ["rust_analyzer"] = function ()
    require("rust-tools").setup {}
  end,
}

-- -----------------------------------------------------------------------------
-- --- LSP KEY MAPPINGS --------------------------------------------------------
-- -----------------------------------------------------------------------------

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)

    -- Incremental renaming
    require('inc_rename').setup {
      input_buffer_type = 'dressing',
    }
    vim.keymap.set('n', '<leader>cr', function()
      return ':IncRename ' .. vim.fn.expand('<cword>')
    end, { expr = true })

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

    -- Manage LSP workspaces
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    -- TODO: replace with format.nvim
    -- vim.keymap.set('n', '<leader>lf', function()
    --   vim.lsp.buf.format { async = true }
    -- end, opts)
    vim.keymap.set('n', '<leader>lf', ':Format<cr>')


    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
})
