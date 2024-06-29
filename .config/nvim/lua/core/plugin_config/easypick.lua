local easypick = require("easypick")
require("easypick").setup({
  pickers = {
    {
      name = "dotfiles",
      command = "cfg ls-tree --full-tree --name-only -r HEAD | sed \"s|^|~/|\"",
      previewer = easypick.previewers.default()
    },
  }
})
