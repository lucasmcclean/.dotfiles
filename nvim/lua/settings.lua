-- Leader Keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Searching
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- Folding
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Display
vim.opt.list = true
vim.opt.listchars = {
  tab = '· ',
  space = ' ',
  trail = '·',
  extends = '»',
  precedes = '«',
  nbsp = '␣',
}
vim.opt.number = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8
vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.relativenumber = true
vim.opt.lazyredraw = true
vim.g.have_nerd_font = true

-- Formatting
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = -1
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.formatoptions:remove { 'c', 'r', 'o' }

-- Window Splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Command & Input Behavior
vim.opt.inccommand = 'nosplit'
vim.opt.clipboard = 'unnamedplus'

-- Timings
vim.opt.updatetime = 200
vim.opt.timeoutlen = 250
vim.opt.ttimeoutlen = 10

-- Undo & Backup
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath 'data' .. '/undo'
local undodir = vim.opt.undodir:get()[1]
vim.fn.mkdir(undodir, 'p')

-- Wild Menu
vim.opt.pumblend = 10
vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'

-- Completion
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- Files
vim.opt.autoread = true

-- Netrw
vim.g.netrw_fastbrowse = 0

-- Status Line
vim.opt.statusline = table.concat {
  '  %f %m',
  '%=',
  '  %l,%c',
  '  %p%%  ',
}

-- Remaps for MacOS
if vim.fn.has 'mac' == 1 then
  vim.keymap.set('i', 'jk', '<Esc>', { noremap = true, silent = true })
end

