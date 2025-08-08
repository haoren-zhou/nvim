-- HACK: Disable NvChad LSP signature auto trigger
local custom_group = vim.api.nvim_create_augroup("DisableLspSignature", { clear = false })

vim.api.nvim_create_autocmd("InsertEnter", {
  group = custom_group,
  callback = function()
    vim.api.nvim_del_augroup_by_name "LspSignature"
    -- commit suicide
    vim.api.nvim_del_augroup_by_name "DisableLspSignature"
  end,
})

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        -- ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      },
      signature = {
        enabled = true,
        auto_open = {
          enabled = true,
          -- throttle = 100,
        },
      },
      hover = {
        enabled = true,
        silent = true,
      },
    },
    notify = {
      enabled = false, -- use snacks.nvim notifier instead
    },
    presets = {
      command_palette = true,
      long_message_to_split = true,
      lsp_doc_border = true,
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- "rcarriga/nvim-notify",
  },
}
