return {
  "jmbuhr/otter.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  ft = { "markdown", "quarto", "rmd" },
  config = function()
    vim.api.nvim_create_autocmd({ "FileType" }, {
      pattern = {
        "markdown",
        "quarto",
        "rmd",
      },
      group = vim.api.nvim_create_augroup("otter-activate", { clear = true }),
      callback = function()
        require("otter").activate()
      end,
    })
  end,
}
