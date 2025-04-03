local langs = require("languages")

return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			local linters_by_ft = {}

			for _, config in pairs(langs) do
				if config.linters and config.linters.list and config.linters.filetypes then
					for _, linter in ipairs(config.linters.list) do
						for _, ft in pairs(config.linters.filetypes) do
							if not linters_by_ft[ft] then
								linters_by_ft[ft] = {}
							end
							table.insert(linters_by_ft[ft], linter.name or linter)
						end
						if type(linter) == "table" then
							lint.linters[linter.name] = vim.tbl_deep_extend("force", lint.linters[linter.name] or {}, {
								args = linter.args or {},
								cmd = linter.cmd or linter.name or linter,
								ignore_exitcode = linter.ignore_exitcode or false,
								parser = linter.parser or nil,
								stdin = linter.stdin or false,
								stream = linter.stream or nil,
							})
						end
					end
				end
			end
			lint.linters_by_ft = linters_by_ft
		end,
	},

	{
		"rshkarin/mason-nvim-lint",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			local ensure_installed = {}
			for _, config in pairs(langs) do
				if config.formatters and config.formatters.list then
					for _, formatter in pairs(config.formatters.list) do
						table.insert(ensure_installed, formatter.name or formatter)
					end
				end
			end
			require("mason-nvim-lint").setup({
				ensure_installed = ensure_installed,
			})
		end,
	},
}
