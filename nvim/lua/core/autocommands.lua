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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  group = vim.api.nvim_create_augroup("md-wrap", { clear = true }),
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.formatoptions:append("t")
  end,
})

local function wc_rt()
  local word_count = vim.fn.wordcount().words
  local reading_time = word_count / 200
  return string.format("%d:%0.1f", word_count, reading_time)
end

_G.wc_rt = wc_rt

local function is_text_file()
  local ext = vim.fn.expand('%:e')
  return ext == 'txt' or ext == 'md'
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if is_text_file() then
      vim.opt.statusline = "  %f %m %= %l,%c  %{v:lua.wc_rt()}  %p%%  "
    else
      vim.opt.statusline = "  %f %m %= %l,%c  %p%%  "
    end
  end,
})
