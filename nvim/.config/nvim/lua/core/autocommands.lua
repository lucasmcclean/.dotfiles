local language_keymaps = require("core.language_keymaps")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    language_keymaps.set_keymaps(event.buf)
  end,
})

vim.api.nvim_create_autocmd("LspDetach", {
  group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
  callback = function(event)
    vim.lsp.buf.clear_references()
  end,
})

--[[ vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Format the document before saving",
  pattern = "*",
  callback = function()
    vim.lsp.buf.format()
  end,
}) ]]
