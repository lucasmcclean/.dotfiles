vim.lsp.config.global = vim.lsp.config.global or {}

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.cmd.packadd 'nvim-lspconfig'
    vim.cmd.packadd 'cmp-nvim-lsp'
    local caps = require('cmp_nvim_lsp').default_capabilities()
    vim.lsp.config.global.capabilities = caps
    vim.lsp.config.global.inlay_hints = { enabled = false }
  end,
  once = true,
})

vim.lsp.config.ltex_plus = {
  settings = {
    ltex = {
      language = 'en-GB',
      additionalRules = {
        languageModel = {
          paths = { vim.fn.expand '~/.config/models/ngrams' },
        },
      },
      dictionary = { ['en-GB'] = {} },
      enabled = { 'markdown', 'text', 'latex' },
    },
  },
  filetypes = { 'markdown', 'text', 'latex' },
}

vim.lsp.config.lua_ls = {
  cmd = { 'lua-language-server' },
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      workspace = { library = vim.api.nvim_get_runtime_file('', true) },
    },
  },
  filetypes = { 'lua' },
}

vim.lsp.config.jdtls = {
  cmd = {
    vim.fn.expand '~/.sdkman/candidates/java/21.0.10-tem/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1G',
    '-jar',
    vim.fn.glob(
      vim.fn.expand '/opt/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'
    ),
    '-configuration',
    vim.fn.expand '~/.local/share/jdtls/config_linux',
    '-data',
    vim.fn.expand '~/.cache/jdtls/workspace',
  },
  rootMarkers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-21',
            path = vim.fn.expand '~/.sdkman/candidates/java/21.0.10-tem',
          },
        },
      },
    },
  },
  filetypes = { 'java' },
}

vim.lsp.config.rust_analyzer = {
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = true,
      check = { command = 'clippy' },
    },
  },
}

vim.lsp.config.asm_lsp = {
  rootMarkers = { '.asm-lsp.toml', '.git' },
}

vim.lsp.enable('ltex_plus', true)
vim.lsp.enable('lua_ls', true)
vim.lsp.enable('jdtls', true)
vim.lsp.enable('rust_analyzer', true)
vim.lsp.enable('asm_lsp', true)
vim.lsp.enable('pylsp', true)
vim.lsp.enable('gopls', true)
vim.lsp.enable('ts_ls', true)
vim.lsp.enable('html', true)
vim.lsp.enable('cssls', true)
vim.lsp.enable('svelte', true)
vim.lsp.enable('bashls', true)
vim.lsp.enable('jsonls', true)
vim.lsp.enable('dockerls', true)
vim.lsp.enable('marksman', true)
vim.lsp.enable('clangd', true)
vim.lsp.enable('gdscript', true)
vim.lsp.enable('tailwindcss', true)
