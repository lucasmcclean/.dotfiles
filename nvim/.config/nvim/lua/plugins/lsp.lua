return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local lspconfig = require("lspconfig")
      local caps = require("cmp_nvim_lsp").default_capabilities()

      local function on_attach(client, bufnr) end

      local function setup_server(name, opts)
        opts = opts or {}
        opts.capabilities = caps
        opts.on_attach = on_attach
        opts.flags = opts.flags or { debounce_text_changes = 150 }
        lspconfig[name].setup(opts)
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

      setup_server("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
          },
        },
      })

      local servers = {
        "pyright", -- python
        "gopls", -- go
        "rust_analyzer", -- rust
        "ts_ls", -- typescript
        "html", -- html
        "cssls", -- css
        "tailwindcss", -- tailwindcss
        "svelte", -- svelte
        "bashls", -- bash
        "jsonls", -- json
        "dockerls", -- docker
        "marksman", -- markdown
        "clangd", -- c/c++
      }

      for _, server in ipairs(servers) do
        setup_server(server)
      end
    end,
  },
}
