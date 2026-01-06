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
        filetypes = { "lua" },
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
          },
        },
      })

      setup_server("pyright")
      setup_server("gopls")
      setup_server("rust_analyzer")
      setup_server("tsserver")
      setup_server("html")
      setup_server("cssls")
      setup_server("svelte")
      setup_server("bashls")
      setup_server("jsonls")
      setup_server("dockerls")
      setup_server("marksman")
      setup_server("clangd")
      setup_server("jdtls")
      setup_server("gdscript")
    end,
  },
}
