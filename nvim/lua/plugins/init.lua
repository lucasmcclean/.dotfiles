local pack = vim.pack

local plugins = {
  { src = 'https://github.com/windwp/nvim-autopairs', opt = true },
  { src = 'https://github.com/windwp/nvim-ts-autotag', opt = true },
  { src = 'https://github.com/numToStr/Comment.nvim', opt = true },
  { src = 'https://github.com/hrsh7th/cmp-nvim-lsp', opt = true },
  { src = 'https://github.com/hrsh7th/nvim-cmp', opt = true },
  { src = 'https://github.com/hrsh7th/cmp-buffer', opt = true },
  { src = 'https://github.com/hrsh7th/cmp-path', opt = true },
  { src = 'https://github.com/stevearc/conform.nvim', opt = true },
  { src = 'https://github.com/lewis6991/gitsigns.nvim', opt = true },
  { src = 'https://github.com/habamax/vim-godot', opt = true },
  { src = 'https://github.com/skywind3000/asyncrun.vim', opt = true },
  { src = 'https://github.com/folke/snacks.nvim', opt = true },
  { src = 'https://github.com/teatek/gdscript-extended-lsp.nvim', opt = true },
  { src = 'https://github.com/mfussenegger/nvim-lint', opt = true },
  { src = 'https://github.com/neovim/nvim-lspconfig', opt = true },
  { src = 'https://github.com/nvim-lua/plenary.nvim', opt = true },
  {
    src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
    opt = true,
  },
  {
    src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim',
    opt = true,
  },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons', opt = true },
  { src = 'https://github.com/nvim-telescope/telescope.nvim', opt = true },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', opt = true },
  { src = 'https://github.com/folke/tokyonight.nvim' },
}

vim.pack.add(plugins)

require 'plugins.ui'
require 'plugins.completion'
require 'plugins.treesitter'
require 'plugins.telescope'
require 'plugins.formatters'
require 'plugins.lint'
require 'plugins.lsp'
require 'plugins.gitsigns'
require 'plugins.gdscript'

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.cmd.packadd 'nvim-autopairs'
    require('nvim-autopairs').setup {}
    vim.cmd.packadd 'nvim-ts-autotag'
    require('nvim-ts-autotag').setup()
    vim.cmd.packadd 'Comment.nvim'
    require('Comment').setup {
      toggler = {
        line = 'gcc',
        block = 'gbc',
      },
      opleader = {
        line = 'gc',
        block = 'gb',
      },
      extra = {
        above = 'gcO',
        below = 'gco',
        eol = 'gcA',
      },
      mappings = {
        basic = true,
        extra = true,
      },
    }
  end,
  once = true,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.cmd.packadd 'snacks.nvim'
    require('snacks').setup {
      picker = {
        sources = {
          explorer = {
            exclude = { '*.uid', 'server.pipe' },
          },
        },
      },
    }
  end,
  once = true,
})

