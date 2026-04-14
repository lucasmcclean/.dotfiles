vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.cmd.packadd 'gdscript-extended-lsp.nvim'
  end,
  once = true,
})

require('gdscript-extended-lsp').setup {
  view_type = 'floating',
  picker = 'snacks',
}

