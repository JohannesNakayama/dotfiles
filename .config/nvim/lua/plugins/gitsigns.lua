return {
  -- Show git status information on buffers
  'lewis6991/gitsigns.nvim',
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require("gitsigns")

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal({']c', bang = true})
        else
          gitsigns.nav_hunk('next')
        end
      end, { desc = "Move to next hunk" })

      map('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal({'[c', bang = true})
        else
          gitsigns.nav_hunk('prev')
        end
      end, { desc = "Move to previous hunk" })

      map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "Stage hunk" })
      map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "Reset hunk" })

      map('v', '<leader>hs', function()
        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, { desc = "Stage hunk" })

      map('v', '<leader>hr', function()
        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, { desc = "Reset hunk" })

      map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "Stage buffer" })
      map('n', '<leader>hR', gitsigns.reset_buffer, { desc = "Reset buffer" })
      map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "Preview hunk" })
      map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = "Perview hunk inline" })

      map('n', '<leader>hb', function()
        gitsigns.blame_line({ full = true })
      end, { desc = "Show blame in floating window" })

      map('n', '<leader>hD', function()
        gitsigns.diffthis('~')
      end, { desc = "Show diff" })

      map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "Toggle current line blame" })
      map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = "Toggle word diff" })
    end,
  },
}
