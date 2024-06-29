require('copilot').setup({
  suggestion = {
    auto_trigger = true,
    keymap = {
      accept = "<C-tab>",
      accept_word = "<C-t>",
      accept_line = false,
      next = "<C-n>",
      dismiss = "<C-,>",
    },
  },
  filetypes = {
    yaml = true,
    markdown = false,
    gitcommit = true,
    json = true,
  },
})
