return {
  -- Switch between certain defined patterns (e.g. true <-> false)
  {
    'AndrewRadev/switch.vim',
    keys = {
      { 'gs', desc = 'Toggle true/false and other patterns' }
    },
    config = function()
      vim.g.switch_custom_definitions = {
        { "on",         "off" },
        { "==",         "!=" },
        { " < ",        " > " },
        { "<=",         ">=" },
        { " + ",        " - " },
        { "-=",         "+=" },
        { "and",        "or" },
        { "YES",        "NO" },
        { "yes",        "no" },
        { "first",      "last" },
        { "max",        "min" },
        { "left",       "right" },
        { "top",        "bottom" },
        { "margin",     "padding" },
        { "height",     "width" },
        { "absolute",   "relative" },
        { "show",       "hide" },
        { "visible",    "hidden" },
        { "add",        "remove" },
        { "up",         "down" },
        { "before",     "after" },
        { "inside",     "outside" },
      }
    end,
  },
}
