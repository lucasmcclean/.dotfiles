local languages = require("res.languages")

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
      local mason_langs = {}
      for _, lang in pairs(languages) do
        if not lang.skip_mason then
          table.insert(mason_langs, lang.server)
        end
      end

      require("mason-lspconfig").setup({
        ensure_installed = mason_langs,
      })
    end,
  },

  { "WhoIsSethDaniel/mason-tool-installer.nvim" },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      for _, language in pairs(languages) do
        lspconfig[language.server].setup(vim.tbl_deep_extend("force", language.config, {
          capabilities = capabilities,
        }))
      end
    end,
  },

  { "hrsh7th/cmp-nvim-lsp" },

  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        completion = { completeopt = "menu,menuone,noinsert" },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },
}
