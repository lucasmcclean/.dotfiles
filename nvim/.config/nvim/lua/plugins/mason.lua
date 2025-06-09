local langs = require("config.langs")

return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "rshkarin/mason-nvim-lint",
      "zapling/mason-conform.nvim",
    },
    opts = {},
    config = function(_, _)
      require("mason").setup()

      require("mason-lspconfig").setup({
        ensure_installed = langs.servers,
        automatic_installation = false,
      })

      require("mason-nvim-lint").setup({
        ensure_installed = langs.mason_linters,
        automatic_installation = false,
      })

      require("mason-conform").setup({
        ensure_installed = langs.mason_formatters,
        automatic_installation = false,
      })
    end,
  },
}
