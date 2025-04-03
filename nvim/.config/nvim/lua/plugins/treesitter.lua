local languages = require("languages")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			auto_install = false,
			indent = { enable = true },
			highlight = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter.install").prefer_git = true
			local ts_parsers = require("nvim-treesitter.parsers")

			local ensure_installed = {}
			local available_parsers = ts_parsers.get_parser_configs()

			for lang, _ in pairs(languages) do
				if vim.tbl_contains(available_parsers, lang) then
					table.insert(ensure_installed, lang)
				end
			end
			opts.ensure_installed = ensure_installed
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	{ "nvim-treesitter/nvim-treesitter-textobjects" },
}
