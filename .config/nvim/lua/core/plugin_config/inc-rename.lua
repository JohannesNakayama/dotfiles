-- TODO: stay in "noice/dressing" window for renaming (not lua command line)
require('inc_rename').setup({
  input_buffer_type = 'dressing',
})

-- vim.keymap.set('n', '<leader>cr', function()
--   return ':IncRename ' .. vim.fn.expand('<cword>')
-- end, { expr = true })
