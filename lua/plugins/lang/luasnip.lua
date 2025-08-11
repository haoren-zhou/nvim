return {
  "L3MON4D3/LuaSnip",
  tag = "v2.4.0",
  build = "make install_jsregexp",
  dependencies = "rafamadriz/friendly-snippets",
  opts = {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
  },
  config = function(_, opts)
    require("luasnip").config.set_config(opts)
    require "nvchad.configs.luasnip"
  end,
}
