-- Leader Keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Searching
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- Folding
vim.opt.foldlevel = 99
vim.opt.regexpengine = 0
vim.opt.foldmethod = "manual"

-- Display
vim.opt.list = true
vim.opt.number = true
vim.opt.scrolloff = 10
vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
--TODO: Install
-- vim.g.have_nerd_font = true
vim.opt.termguicolors = true
vim.opt.relativenumber = true

-- Formatting
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.breakindent = true
vim.opt.smartindent = true

-- Window Splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Command & Input Behavior
vim.opt.inccommand = "split"
vim.opt.clipboard = "unnamedplus"

-- Timings
vim.opt.updatetime = 250
vim.opt.timeoutlen = 350
vim.opt.ttimeoutlen = 10

-- Undo & Backup
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- WARN: Testing Wildmenu
vim.opt.pumblend = 10
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:list,full"

-- Netrw
vim.g.netrw_fastbrowse = 0
