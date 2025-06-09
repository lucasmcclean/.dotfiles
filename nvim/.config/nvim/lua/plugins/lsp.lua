local langs = require("config.langs")

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local lspconfig = require("lspconfig")
      local caps      = require("cmp_nvim_lsp").default_capabilities()
      for _, server in ipairs(langs.servers) do
        if lspconfig[server] then
          lspconfig[server].setup({ capabilities = caps })
        else
          vim.notify("LSP server not found: " .. server, vim.log.levels.WARN)
        end
      end
    end,
  },
}
