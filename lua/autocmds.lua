require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd("BufDelete", {
  desc = "Show Nvdash when all buffers are closed",
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  desc = "Open Nvdash on startup only if no other buffers are loaded",
  callback = function()
    local bufs = vim.api.nvim_list_bufs()
    local buf_name = vim.api.nvim_buf_get_name(bufs[1])

    if #bufs == 1 and buf_name == "" then
      vim.cmd "Nvdash"
    end
  end,
})

autocmd({ "QuitPre" }, {
  desc = "Close any extra buffers on quit",
  callback = function()
    vim.cmd [[silent! NvimTreeClose]]
    vim.cmd [[silent! Trouble qflist close]]
    vim.cmd [[silent! Trouble loclist close]]
    vim.cmd [[silent! Trouble lsp close]]
    vim.cmd [[silent! Trouble symbols close]]
    vim.cmd [[silent! Trouble diagnostics close]]
    vim.cmd [[silent! cclose]]
  end,
})

-- autocmd("QuickFixCmdPost", {
--   desc = "Automatically open Trouble quickfix",
--   callback = function()
--     vim.cmd [[Trouble qflist open]]
--   end,
-- })

-- WARN: testing to see if this screws up anything
autocmd("BufRead", {
  callback = function(ev)
    if vim.bo[ev.buf].buftype == "quickfix" then
      vim.schedule(function()
        vim.cmd [[cclose]]
        vim.cmd [[Trouble qflist open]]
      end)
    end
  end,
})
