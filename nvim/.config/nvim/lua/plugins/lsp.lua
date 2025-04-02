local langs = require("languages")

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      for _, config in pairs(langs) do
        if config.lsp and config.lsp.server then
          local lsp_config = vim.tbl_deep_extend("force", config.lsp.config or {}, {
            capabilities = capabilities,
          })
          lspconfig[config.lsp.server].setup(lsp_config)
        end
      end
    end,
  },
}
