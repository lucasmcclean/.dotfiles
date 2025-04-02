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
      list = {
        { name = "prettier" },
      },
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
        { name = "ruff",  args = { "--config", "pyproject.toml" } },
        { name = "flake8" },
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
        { name = "golangci-lint" },
      },
      filetypes = { "go" },
    },
    -- formatters = {
    --   list = {
    --     { name = "gofmt" },
    --   },
    --   filetypes = { "go" },
    -- },
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
      list = {
        { name = "stylelint" },
      },
      filetypes = { "css", "scss", "less" },
    },
    formatters = {
      list = {
        { name = "prettier" },
      },
      filetypes = { "css" },
    },
  },

  lua = {
    lsp = {
      server = "lua_ls",
      filetypes = { "lua" },
    },
    linters = {
      list = {
        { name = "luacheck" },
      },
      filetypes = { "lua" },
    },
    formatters = {
      list = {
        { name = "stylua" },
      },
      filetypes = { "lua" },
    },
  },

  typescript = {
    lsp = {
      server = "ts_ls",
      filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    },
    linters = {
      list = {
        { name = "eslint_d" },
      },
      filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    },
    formatters = {
      list = {
        { name = "prettier" },
      },
      filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    },
  },

  markdown = {
    lsp = {
      server = "marksman",
      filetypes = { "markdown" },
    },
    linters = {
      list = {
        { name = "markdownlint" },
      },
      filetypes = { "markdown" },
    },
    formatters = {
      list = {
        { name = "prettier" },
      },
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
    -- linters = {
    --   list = {
    --     { name = "clippy" },
    --   },
    --   filetypes = { "rust" },
    -- },
    formatters = {
      list = {
        { name = "rustfmt" },
      },
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
      list = {
        { name = "cpplint" },
      },
      filetypes = { "c", "cpp" },
    },
    formatters = {
      list = {
        { name = "clang-format" },
      },
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
    --   server = "gdscript",
    --   filetypes = { "gd", "gdscript", "gdscript3" },
    -- },
    linters = {},
    formatters = {},
  },
}
