local langs = require("languages")

return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")
			local formatters_by_ft = {}

			for lang, config in pairs(langs) do
				if config.formatters and config.formatters.list then
					formatters_by_ft[lang] = formatters_by_ft[lang] or {}

					for _, formatter in pairs(config.formatters.list) do
						table.insert(formatters_by_ft[lang], formatter.name or formatter)
					end
				end
			end

			conform.setup({ formatters_by_ft = formatters_by_ft })
		end,
	},

	{
		"zapling/mason-conform.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			local ensure_installed = {}
			for _, config in pairs(langs) do
				if config.linters and config.linters.list then
					for _, linter in pairs(config.linters.list) do
						table.insert(ensure_installed, linter.name or linter)
					end
				end
			end
			require("mason-conform").setup({
				ensure_installed = ensure_installed,
			})
		end,
	},
}
