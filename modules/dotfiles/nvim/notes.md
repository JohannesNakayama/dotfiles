# Plugins to figure out

- manipulate text objects using treesitter: `'nvim-treesitter/nvim-treesitter-textobjects'`
- linting/formatting: `'mfussenegger/nvim-lint'`
- modern multicursor: `'jake-stewart/multicursor.nvim'`

- TypeScript tools, incl. LSP:
```
{
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {},
},
```

- integration with tmux: `'christoomey/vim-tmux-navigator'`
