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
          markdown = { "prettier-markdown" },
        },
        formatters = {
          ["prettier-markdown"] = {
            command = "prettier",
            args = {
              "--parser",
              "markdown",
              "--print-width",
              "80",
              "--prose-wrap",
              "always",
              "--use-tabs",
              "--embedded-language-formatting",
              "auto",
            },
            stdin = true,
          },
        },
        format_after_save = {
          lsp_fallback = false,
          async = true,
          timeout_ms = 1000,
        },
      })
    end,
  },
}
