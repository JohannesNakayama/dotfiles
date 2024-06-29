require('copilot').setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
  filetypes = {
    yaml = true,
    markdown = false,
    gitcommit = true,
    json = true,
  },
})

-- Configuration without copilot-cmp
-- TODO: decide whether it's better or worse with snippets than ghost text
-- require('copilot').setup({
--   suggestion = {,
--     enabled = true,
--     auto_trigger = true,
--     keymap = {
--       accept = "<C-tab>",
--       accept_word = "<C-t>",
--       accept_line = false,
--       next = "<C-n>",
--       dismiss = "<C-,>",
--     },
--   },
--   filetypes = {
--     yaml = true,
--     markdown = false,
--     gitcommit = true,
--     json = true,
--   },
-- })

require("copilot_cmp").setup()
