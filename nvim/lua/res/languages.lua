return {
	html = {
		server = "html",
		config = {
			filetypes = { "html", "javascript", "typescript", "javascriptreact", "typescriptreact" },
		},
	},
	python = {
		server = "pyright",
		config = {
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "strict",
						autoSearchPaths = true,
						autoImportCompletions = true,
					},
				},
			},
		},
	},
	go = {
		server = "gopls",
		config = {
			settings = {
				gopls = {
					staticcheck = true,
					usePlaceholders = true,
					completeUnimported = true,
				},
			},
		},
	},
	css = {
		server = "cssls",
		config = {
			settings = {
				css = {
					lint = {
						unknownAtRules = "ignore",
					},
				},
			},
		},
	},
	lua = {
		server = "lua_ls",
		config = {},
	},
	typescript = {
		server = "ts_ls",
		config = {},
	},
	markdown = {
		server = "marksman",
		config = {},
	},
	rust = {
		server = "rust_analyzer",
		config = {
			settings = {
				["rust-analyzer"] = {
					cargo = {
						runBuildScripts = true,
					},
					procMacro = {
						enable = true,
					},
				},
			},
		},
	},
	c = {
		server = "clangd",
		config = {
			cmd = { "clangd", "--background-index" },
			filetypes = { "c", "cpp", "objc", "objcpp" },
		},
	},
}
