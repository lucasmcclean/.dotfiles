local langs = require("languages")

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local servers = {}
      for _, config in pairs(langs) do
        if config.lsp and config.lsp.server then
          table.insert(servers, config.lsp.server)
        end
      end

      require("mason-lspconfig").setup({
        ensure_installed = servers,
      })
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      local tools = {}

      for _, config in pairs(langs) do
        if config.linters and config.linters.list then
          for _, linter in pairs(config.linters.list) do
            if type(linter) == "string" then
              table.insert(tools, linter)
            elseif type(linter) == "table" then
              table.insert(tools, linter.name)
            end
          end
        end

        if config.formatters and config.formatters.list then
          for _, formatter in pairs(config.formatters.list) do
            if type(formatter) == "string" then
              table.insert(tools, formatter)
            elseif type(formatter) == "table" then
              table.insert(tools, formatter.name)
            end
          end
        end
      end

      require("mason-tool-installer").setup({
        ensure_installed = tools,
        quiet = true,
      })
    end
  },

}
