local langs = require("languages")

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			for _, config in pairs(langs) do
				if config.lsp and config.lsp.server then
					local lsp_config = vim.tbl_deep_extend("force", config.lsp.config or {}, {
						capabilities = capabilities,
					})
					if lspconfig[config.lsp.server] then
						lspconfig[config.lsp.server].setup(lsp_config)
					end
				end
			end
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
      local ensure_installed = {}
			for _, config in pairs(langs) do
				if config.lsp and config.lsp.server then
					table.insert(ensure_installed, config.lsp.server)
				end
			end
			require("mason-lspconfig").setup({
        ensure_installed = ensure_installed,
      })
		end,
	},
}
