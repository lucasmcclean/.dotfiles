vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.cmd.packadd 'tokyonight.nvim'
    local tokyonight = require 'tokyonight'
    tokyonight.setup {
      transparent = true,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
    }
    vim.cmd.colorscheme 'tokyonight'

    vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'none', fg = '#a9b1d6' })
    vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'none', fg = '#5c6370' })
    vim.api.nvim_set_hl(0, 'TabLineSel', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'MsgArea', { bg = 'none' })

    if vim.g.have_nerd_font then
      vim.cmd.packadd 'nvim-web-devicons'
      require('nvim-web-devicons').setup()
    end
  end,
  once = true,
})

