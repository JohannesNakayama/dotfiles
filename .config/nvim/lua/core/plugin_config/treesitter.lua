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
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
    'yaml',
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,
  auto_install = true,
  highlight = {
    enable = true,
  },
})

require('nvim-treesitter.install').prefer_git = true
