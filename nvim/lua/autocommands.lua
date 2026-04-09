vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Persist cursor position',
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Auto create missing directories on save',
  callback = function(args)
    local dir = vim.fn.fnamemodify(args.file, ':p:h')
    vim.fn.mkdir(dir, 'p')
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Buffer local keymaps for the LSP',
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local buf = event.buf
    require('keymaps').set_lsp_keymaps(buf)
  end,
})

vim.api.nvim_create_autocmd('LspDetach', {
  desc = 'Clean up on LSP detach',
  group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
  callback = function(_) vim.lsp.buf.clear_references() end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
  callback = function()
    local ft = vim.bo.filetype
    if require('lint').linters_by_ft[ft] then require('lint').try_lint() end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Wrap text in Markdown files',
  pattern = 'markdown',
  group = vim.api.nvim_create_augroup('md-wrap', { clear = true }),
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.textwidth = 80
    vim.opt_local.linebreak = true
    vim.opt_local.formatoptions:append 't'
  end,
})
