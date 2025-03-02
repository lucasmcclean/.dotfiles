local languages = require("config.languages")

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = vim.tbl_keys(languages),
			auto_install = true,
			indent = { enable = true },
			highlight = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter.install").prefer_git = true
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	{ "nvim-treesitter/nvim-treesitter-textobjects" },
}
