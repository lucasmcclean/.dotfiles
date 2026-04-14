vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    vim.cmd.packadd 'nvim-treesitter'
    local ft = vim.bo[args.buf].filetype
    if ft == 'tsx' or ft == 'jsx' then
      pcall(vim.treesitter.start, args.buf, 'tsx')
    else
      pcall(vim.treesitter.start, args.buf)
    end
  end,
})

require('nvim-treesitter').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
}

