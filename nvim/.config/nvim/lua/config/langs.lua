local M = {}

M.servers = {
  "gopls",
  "pyright",
  "rust_analyzer",
  "ts_ls",
  "html",
  "cssls",
  "tailwindcss",
}

M.parsers = {
  "go",
  "python",
  "rust",
  "javascript",
  "typescript",
  "html",
  "css",
  "bash",
}

M.linters_by_ft = {
  python     = { "ruff" },
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  html       = { "htmlhint" },
  css        = { "stylelint" },
}

M.formatters_by_ft = {
  go         = { "goimports", "gofumpt" },
  python     = { "ruff" },
  rust       = { "rustfmt" },
  javascript = { "prettier" },
  typescript = { "prettier" },
  html       = { "prettier" },
  css        = { "prettier" },
  ["*"]      = { "trim_whitespace" },
}

local function flatten(tbls)
  return vim.tbl_flatten(vim.tbl_values(tbls))
end

M.mason_linters = flatten(M.linters_by_ft)
M.mason_formatters = flatten(M.formatters_by_ft)

M.mason_packages = vim.tbl_flatten({
  M.servers,
  M.mason_linters,
  M.mason_formatters,
})

return M
