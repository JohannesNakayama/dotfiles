-- ============================================================================
-- === KEY MAPPINGS ===========================================================
-- ============================================================================

-- l/L: next/prev buffer
-- L was: place cursor at bottom of screen
-- --> https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L34
vim.keymap.set('n', 'l', ':bnext<CR>')
vim.keymap.set('v', 'l', ':bnext<CR>')
vim.keymap.set('n', 'L', ':bprev<CR>')
vim.keymap.set('v', 'L', ':bprev<CR>')

-- Efficient one-button save/close bindings for neo2 layout
-- --> https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L41
vim.keymap.set('n', 'ö', ':update<CR>')
vim.keymap.set('v', 'ö', '<esc>:update<CR>gv')
vim.keymap.set('n', 'ä', ':q<CR>')
vim.keymap.set('v', 'ä', '<esc>:q<CR>')
vim.keymap.set('n', 'ü', ':bd<CR>')
vim.keymap.set('v', 'ü', '<esc>:q<CR>')

-- Source/edit nvim config
-- --> https://learnvimscriptthehardway.stevelosh.com/chapters/07.html
-- --> https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L135
vim.keymap.set('n', '<leader>sv', ':luafile $MYVIMRC<CR>')
vim.keymap.set('v', '<leader>sv', ':luafile $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>vv', ':e $MYVIMRC<CR>')

-- Don't lose selection when indenting //<- fdietze/dotfiles
-- --> https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L104
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '=', '=gv')

-- Highlight off after search
vim.keymap.set('n', '<leader>h', ':nohl<CR>')

vim.keymap.set('n', 'Y', 'y$', { desc = 'yank till end of line. (Y behaves like D and C)' })
vim.keymap.set('n', "<leader>p", "v$<Left>pgvy", { desc = 'paste over rest of line' })


vim.keymap.set({'n', 'v', 'i'}, '<c-m-i>', '<cmd> TmuxNavigateLeft<cr>')
vim.keymap.set({'n', 'v', 'i'}, '<c-m-e>', '<cmd> TmuxNavigateRight<cr>')
vim.keymap.set({'n', 'v', 'i'}, '<c-m-l>', '<cmd> TmuxNavigateUp<cr>')
vim.keymap.set({'n', 'v', 'i'}, '<c-m-a>', '<cmd> TmuxNavigateDown<cr>')

vim.keymap.set('n', "<leader>n",
  function()
    local has_errors = next(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })) ~= nil
    if has_errors then
      vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR, float = true }
    else
      local has_warnings = next(vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })) ~=
          nil
      if has_warnings then
        vim.diagnostic.goto_next { severity = vim.diagnostic.severity.WARN, float = true }
      else
        vim.diagnostic.goto_next { float = true }
      end
    end
  end,
  { desc = "Jump to next LSP diagnostic" }
)

-- Toggle a specific character at the end of the current line
local function toggle_char_at_eol(target_char)
  local line_content = vim.api.nvim_get_current_line()

  if line_content:sub(-1) == target_char then
    -- Remove the character if it's at the end
    vim.api.nvim_set_current_line(line_content:sub(1, -2))
  else
    -- Add the character at the end
    vim.api.nvim_set_current_line(line_content .. target_char)
  end
end

vim.keymap.set('n', '<leader>,', function() toggle_char_at_eol(',') end, { desc = 'toggle , at end of line' })
vim.keymap.set('n', '<leader>;', function() toggle_char_at_eol(';') end, { desc = 'toggle ; at end of line' })

