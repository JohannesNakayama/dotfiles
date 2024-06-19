-- ============================================================================
-- === NEOVIM CONFIG ==========================================================
-- ============================================================================

require('core.options')
require('core.plugins')
require('core.plugin_config')
require('core.keymaps')

-- Inspirations:
-- --> https://github.com/fdietze/dotfiles/blob/94ceeae120957ba93752586b45b09339198d277d/.vimrc
-- --> https://www.youtube.com/playlist?list=PLsz00TDipIffxsNXSkskknolKShdbcAL

-- DOTFILES TODO (mostly nvim):
-- -- ----------------------------------------------------------------
-- -- [ ] telescope -> find files -> search in project directory (like ProjectFiles before)
-- -- [ ] gx -> find out why it doesn't work
-- -- [ ] switch back to lazy as package manager?
-- -- [ ] format options (don't continue comment when "o")
-- -- [ ] better workflow for highlight search
-- -- [ ] fix smart home
-- -- [ ] <leader>vt -> open todo file for dotfiles
-- -- [ ] cd temp -> create temporary directory for quick experiments (with prompt whether or not to save it after)
-- -- [ ] xcolor -> :r xcolor
-- -- [ ] dasel tool
-- -- [ ] nix-index -> find out how to install
-- -- [ ] blueman-applet -> bluetooth
-- -- [ ] lightdm -> Felix: https://github.com/fdietze/dotfiles/blob/master/nixos/configuration.nix#L214

-- -- LSP:
-- -- [ ] look into lazy-lsp: https://github.com/dundalek/lazy-lsp.nvim
-- -- [ ] https://github.com/linrongbin16/lsp-progress.nvim
-- -- [ ] https://github.com/VonHeikemen/lsp-zero.nvim
-- -- [ ] SHORTCUT: go to next/previous error

-- -- PLUGINS TO CHECK OUT
-- -- [ ] https://github.com/AndrewRadev/switch.vim
-- -- [ ] https://github.com/nvimtools/none-ls.nvim

-- -- HOME MANAGER
-- -- [ ] config treesitter with neovim in home manager
-- -- [ ] fast dotfile editing -> vd -> in terminal with fzf (git ls-tree)

-- -- DONE
-- -- [x] SHORTCUT: setup go to declaration properly
-- -- [x] https://github.com/arp242/auto_mkdir2.vim
-- -- [x] https://github.com/gioele/vim-autoswap
-- -- [x] https://github.com/lewis6991/gitsigns.nvim
