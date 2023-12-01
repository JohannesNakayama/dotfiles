require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = { 'tsserver' },
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').tsserver.setup {
  capabilities = capabilities,
}
require('lspconfig').emmet_language_server.setup {
  capabilities = capabilities,
}