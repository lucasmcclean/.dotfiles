-- hrsh7th/nvim-cmp
-- hrsh7th/cmp-nvim-lsp
-- neovim/nvim-lspconfig
-- williamboman/mason.nvim

local languages = require("config.languages")

return {
	{ "hrsh7th/cmp-nvim-lsp" },

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

	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
			local mason_registry = require("mason-registry")
			for _, language in pairs(languages) do
				local pkg = mason_registry.get_package(language.server)
				if not pkg:is_installed() then
					pkg:install()
				end
			end
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
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
