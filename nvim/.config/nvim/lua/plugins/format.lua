return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre", "BufNewFile" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          go = { "goimports", "gofumpt", "gofmt" },
          python = { "ruff" },
          lua = { "stylua" },
          rust = { "rustfmt" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          svelte = { "prettier" },
          ["*"] = { "trim_whitespace" },
        },
      })
    end,
  },
}
