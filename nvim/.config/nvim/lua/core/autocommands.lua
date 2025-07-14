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
    require("core.keymaps").set_lsp_keymaps(event.buf)
  end,
})

vim.api.nvim_create_autocmd("LspDetach", {
  group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
  callback = function(_)
    vim.lsp.buf.clear_references()
  end,
})

local md_wrap_group = vim.api.nvim_create_augroup("md-wrap", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  group = md_wrap_group,
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.formatoptions:append("t")
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.md",
  group = md_wrap_group,
  callback = function()
    vim.cmd("normal! mz")
    vim.fn.execute("1,/^---$/normal! j")
    vim.fn.execute("/^---$/+1,$normal! gq")
    vim.cmd("normal! `z")
  end,
})
