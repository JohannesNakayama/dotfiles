-- ============================================================================
-- === KEY MAPPINGS ===========================================================
-- ============================================================================

-- l/L: next/prev buffer [1]
-- L was: place cursor at bottom of screen
vim.keymap.set("n", "l", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("v", "l", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "L", ":bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("v", "L", ":bprev<CR>", { desc = "Previous buffer" })

-- Efficient one-button save/close bindings for neo2 layout [2]
vim.keymap.set("n", "ö", ":update<CR>", { desc = "Save buffer" })
vim.keymap.set("v", "ö", "<esc>:update<CR>gv", { desc = "Save buffer" })
vim.keymap.set("n", "ä", ":q<CR>", { desc = "Quit" })
vim.keymap.set("v", "ä", "<esc>:q<CR>", { desc = "Quit" })
vim.keymap.set("n", "ü", ":bd<CR>", { desc = "Close buffer" })
vim.keymap.set("v", "ü", "<esc>:bd<CR>", { desc = "Close buffer" })

-- Edit nvim config [3, 4]
vim.keymap.set("n", "<leader>vv", ":e $MYVIMRC<CR>", { desc = "Edit neovim config" })

-- Open dotfiles todo file
vim.keymap.set("n", "<leader>vt", ":e $HOME/Sync/notes/todo/dotfiles.md<CR>", { desc = "Edit dotfiles todo file" })

-- Don't lose selection when indenting [5]
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", "=", "=gv", { desc = "Reset indentation" })

-- Highlight off after search
vim.keymap.set("n", "<leader>h", ":nohl<CR>", { desc = "Switch off highlighting" })

-- Convenient yanking/pasting
vim.keymap.set("n", "Y", "y$", { desc = "Yank till end of line. (Y behaves like D and C)" })
vim.keymap.set("n", "<leader>p", "v$<Left>pgvy", { desc = "Paste over rest of line" })
vim.keymap.set("v", "p", "pgvy", { desc = "Keep clipboard when pasting over selection" })

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

vim.keymap.set("n", "<leader>,", function()
	toggle_char_at_eol(",")
end, { desc = "Toggle , at end of line" })
vim.keymap.set("n", "<leader>;", function()
	toggle_char_at_eol(";")
end, { desc = "Toggle ; at end of line" })

-- [1] https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L34
-- [2] https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L41
-- [3] https://learnvimscriptthehardway.stevelosh.com/chapters/07.html
-- [4] https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L135
-- [5] https://github.com/fdietze/dotfiles/blob/9d2e5110cb59ad271af3d3f15b35f47fd9bd8f56/.vimrc_keybindings#L104
