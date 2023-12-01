require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'c',
    'css',
    'gitignore',
    'go',
    'html',
    'javascript',
    'json',
    'julia',
    'lua',
    'luadoc',
    'markdown',
    'nix',
    'python',
    'query',
    'rust',
    'vim',
    'vimdoc',
    'yaml',
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
})
