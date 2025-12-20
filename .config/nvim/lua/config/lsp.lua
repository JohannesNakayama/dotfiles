local lsps = {
  { 'rust_analyzer', { flags = {}, } },
  {
    'gopls',
    {
      cmd = { 'gopls' },
      filetypes = { 'go' },
      root_markers = { 'go.mod' },
    },
  },
  { 'pyright', { flags = {}, } },
  {
    'lua-language-server',
    {
      cmd = { 'lua-language-server' },
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = { 'vim' } -- get language server to recognize `vim`
          },
          workspace = {
            -- Make server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false, -- disable annoying popups about environment
          },
          telemetry = {
            enable = false,
          },
        },
      },
    },
  },
}

for _, lsp in pairs(lsps) do
  local name, config = lsp[1], lsp[2]
  vim.lsp.enable(name)
  if config then
    vim.lsp.config(name, config)
  end
end

-- Global mappings
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Show diagnostic in floating window" })
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic" })
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic" })

vim.diagnostic.config({
  virtual_text = false
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Incremental renaming
    require('inc_rename').setup({
      input_buffer_type = 'dressing',
      input = {
        override = function(conf)
          conf.col = -1
          conf.row = 0
          return conf
        end,
      },
    })
    vim.keymap.set('n', '<leader>cr', function()
      return ':IncRename ' .. vim.fn.expand('<cword>')
    end, { expr = true, desc = "Incremental rename" })

    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
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

    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)

    -- TODO: replace with format.nvim
    -- vim.keymap.set('n', '<leader>lf', function()
    --   vim.lsp.buf.format { async = true }
    -- end, opts)
    -- vim.keymap.set('n', '<leader>lf', ':Format<cr>')
  end,
})
