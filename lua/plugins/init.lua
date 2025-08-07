return {
  -- test new blink
  { import = "nvchad.blink.lazyspec" },

  {
    "Saghen/blink.cmp",
    opts = require "configs.blink",
  },

  { import = "plugins.ui" },
  { import = "plugins.editor" },
  { import = "plugins.tools" },
  { import = "plugins.lang" },
}
