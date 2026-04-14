vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.cmd.packadd 'conform.nvim'
  end,
  once = true,
})

local ft_formatters = {
  go = { 'goimports', 'gofumpt', 'gofmt' },
  python = { 'ruff' },
  lua = { 'stylua' },
  rust = { 'rustfmt' },
  javascript = { 'prettier' },
  typescript = { 'prettier' },
  html = { 'prettier' },
  css = { 'prettier' },
  svelte = { 'prettier' },
  markdown = { 'mdformat-wrap' },
  java = { 'clang-format' },
  gdscript = { 'gdscript-format' },
}

local custom_formatters = {
  ['mdformat-wrap'] = {
    command = 'mdformat',
    args = { '--wrap', '80', '$FILENAME' },
    stdin = false,
  },
  ['gdscript-format'] = {
    command = 'gdscript-format',
  },
}

require('conform').setup {
  formatters_by_ft = ft_formatters,
  formatters = custom_formatters,
  format_after_save = {
    lsp_fallback = false,
    async = true,
    timeout_ms = 1000,
  },
}

vim.keymap.set('n', '<leader>f', function()
  vim.cmd.packadd 'conform.nvim'
  local ok, conform = pcall(require, 'conform')
  if ok then
    conform.format { async = true, lsp_fallback = true }
  end
end, { desc = '[F]ormat Buffer', silent = true })

