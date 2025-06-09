local langs = require("config.langs")

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre", "BufNewFile" },
    config = function()
      require("conform").setup({
        formatters_by_ft = langs.formatters_by_ft,
        format_on_save   = true,
      })
    end,
  },
}
