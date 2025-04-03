return {
	html = {
		lsp = {
			server = "html",
			config = {
				filetypes = { "html", "javascriptreact" },
			},
		},
		linters = {
			list = {
				{ name = "htmlhint", args = { "--config", ".htmlhintrc" } },
			},
			filetypes = { "html" },
		},
		formatters = {
			list = { "prettier" },
			filetypes = { "html" },
		},
	},

	python = {
		lsp = {
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
			filetypes = { "python" },
		},
		linters = {
			list = {
				{ name = "ruff", args = { "--config", "pyproject.toml" } },
				"flake8",
			},
			filetypes = { "python" },
		},
		formatters = {
			list = {
				{ name = "black", args = { "--line-length", "88" } },
				"isort",
			},
			filetypes = { "python" },
		},
	},

	go = {
		lsp = {
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
			filetypes = { "go" },
		},
		linters = {
			list = {
				{
					name = "golangci-lint",
					args = { "run", "--output.json.path=stdout", "--show-stats=false", "--issues-exit-code", "0" },
				},
			},
			filetypes = { "go" },
		},
		formatters = {
			list = { --[["gofmt"]]
			},
			filetypes = { "go" },
		},
	},

	css = {
		lsp = {
			server = "cssls",
			config = {
				settings = {
					css = {
						lint = { unknownAtRules = "ignore" },
					},
				},
			},
			filetypes = { "css" },
		},
		linters = {
			list = { "stylelint" },
			filetypes = { "css", "scss", "less" },
		},
		formatters = {
			list = { "prettier" },
			filetypes = { "css" },
		},
	},

	lua = {
		lsp = {
			server = "lua_ls",
			filetypes = { "lua" },
		},
		linters = {
			list = { "luacheck" },
			filetypes = { "lua" },
		},
		formatters = {
			list = { "stylua" },
			filetypes = { "lua" },
		},
	},

	typescript = {
		lsp = {
			server = "ts_ls",
			filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
		},
		linters = {
			list = { "eslint_d" },
			filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
		},
		formatters = {
			list = { "prettier" },
			filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
		},
	},

	markdown = {
		lsp = {
			server = "marksman",
			filetypes = { "markdown" },
		},
		linters = {
			list = { "markdownlint" },
			filetypes = { "markdown" },
		},
		formatters = {
			list = { "prettier" },
			filetypes = { "markdown" },
		},
	},

	rust = {
		lsp = {
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
			filetypes = { "rust" },
		},
		linters = {
			list = { --[["clippy"]]
			},
			filetypes = { "rust" },
		},
		formatters = {
			list = { "rustfmt" },
			filetypes = { "rust" },
		},
	},

	c = {
		lsp = {
			server = "clangd",
			cmd = { "clangd", "--background-index" },
			filetypes = { "c", "cpp", "objc", "objcpp" },
		},
		linters = {
			list = { "cpplint" },
			filetypes = { "c", "cpp" },
		},
		formatters = {
			list = { "clang-format" },
			filetypes = { "c", "cpp" },
		},
	},

	tailwind = {
		lsp = {
			server = "tailwindcss",
			filetypes = { "css", "html", "javascript", "typescript" },
		},
		linters = {},
		formatters = {},
	},

	gdscript = {
		-- lsp = {
		-- 	server = "gdscript",
		-- 	filetypes = { "gd", "gdscript", "gdscript3" },
		-- },
		linters = {},
		formatters = {},
	},
}
