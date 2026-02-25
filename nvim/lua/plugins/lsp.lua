return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local caps = require("cmp_nvim_lsp").default_capabilities()

      local function on_attach(_, _) end

      local function setup_server(name, opts)
        opts = opts or {}
        opts.capabilities = caps
        opts.on_attach = on_attach
        opts.flags = opts.flags or { debounce_text_changes = 150 }

        vim.lsp.config(name, opts)
        vim.lsp.enable(name)
      end

      setup_server("ltex_plus", {
        settings = {
          ltex = {
            language = "en-GB",
            additionalRules = {
              languageModel = {
                paths = { vim.fn.expand("~/.config/models/ngrams") },
              },
            },
            dictionary = {
              ["en-GB"] = {},
            },
            enabled = { "markdown", "text", "latex" },
          },
        },
        filetypes = { "markdown", "text", "latex" },
      })

      setup_server("lua", {
        cmd = { "lua-language-server" },
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
          },
        },
        filetypes = { "lua" },
      })

      setup_server("jdtls", {
        cmd = {
          vim.fn.expand("~/.sdkman/candidates/java/21-tem/bin/java"),
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-Xmx1G",
          "-jar", vim.fn.glob(vim.fn.expand("~/.local/share/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")),
          "-configuration", vim.fn.expand("~/.local/share/jdtls/config_linux"),
          "-data", vim.fn.expand("~/.local/share/jdtls/workspace"),
        },
        root_dir = require("lspconfig").util.root_pattern(
          ".git", "mvnw", "gradlew", "pom.xml", "build.gradle"
        )(vim.fn.getcwd()) or vim.fn.getcwd(),
        settings = {
          java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = "fernflower" },
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-11",
                  path = vim.fn.expand("~/.sdkman/candidates/java/11.0.23-tem"),
                },
                {
                  name = "JavaSE-21",
                  path = vim.fn.expand("~/.sdkman/candidates/java/21-tem"),
                },
              },
            },
          },
        },
        filetypes = { "java" },
      })

      setup_server("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = true,
            check = {
              command = "clippy",
            },
          },
        }
      })

      setup_server("asm_lsp", {
        root_dir = require("lspconfig").util.root_pattern(
          ".asm-lsp.toml",
          ".git"
        ),
      })

      setup_server("pyright")
      setup_server("gopls")
      setup_server("tsserver")
      setup_server("html")
      setup_server("cssls")
      setup_server("svelte")
      setup_server("bashls")
      setup_server("jsonls")
      setup_server("dockerls")
      setup_server("marksman")
      setup_server("clangd")
      setup_server("gdscript")
    end,
  },
}
