vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.cmd.packadd 'nvim-lint'
  end,
  once = true,
})

local lint = require 'lint'
local parser = require 'lint.parser'

local custom_linters = {
  clippy = {
    cmd = 'cargo',
    stdin = false,
    args = { 'clippy', '--message-format', 'short' },
    stream = 'stderr',
    parser = parser.from_errorformat('%f:%l:%c: %m', {
      source = 'clippy',
      severity = vim.diagnostic.severity.WARN,
    }),
  },
  golangci_lint = {
    cmd = 'golangci-lint',
    stdin = false,
    args = { 'run', '--out-format', 'line-number' },
    stream = 'stdout',
    parser = parser.from_errorformat('%f:%l:%c: %m', {
      source = 'golangci_lint',
      severity = vim.diagnostic.severity.WARN,
    }),
  },
}

for name, def in pairs(custom_linters) do
  lint.linters[name] = def
end

local linters_by_ft = {
  python = { 'ruff' },
  javascript = { 'eslint' },
  typescript = { 'eslint' },
  html = { 'htmlhint' },
  css = { 'stylelint' },
  lua = { 'selene' },
}

lint.linters_by_ft = linters_by_ft

vim.keymap.set('n', '<leader>l', function()
  vim.cmd.packadd 'nvim-lint'
  local ok, lint = pcall(require, 'lint')
  if ok then
    lint.try_lint()
  end
end, { desc = '[L]int Buffer', silent = true })

