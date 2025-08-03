return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "BufReadPost",
  opts = {
    enable = false,
    mode = "cursor",
    max_lines = 3,
    multiline_threshold = 1,
  },
}
