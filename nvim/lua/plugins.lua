local pack = vim.pack

local function loaded_animation()
  local active = true

  local function cancel_animation() active = false end

  vim.api.nvim_create_autocmd('CmdlineEnter', {
    callback = cancel_animation,
    once = true,
  })

  local function schedule(fn, delay)
    vim.defer_fn(function()
      if active then fn() end
    end, delay)
  end

  local base_chars = { '░', '▒', '▓', ' ', ' ' }
  local matrix_chars = { '0', '1' }
  local line_length = 16
  local frames = 90

  local start_delay = 50
  local end_delay = 40

  for f = 1, frames do
    local delay = start_delay
      + (end_delay - start_delay) * (f - 1) / (frames - 1)

    schedule(function()
      local line = {}

      local prob = math.min(1, f / (frames / 1.2))

      for i = 1, line_length do
        if math.random() < prob then
          line[i] = matrix_chars[math.random(#matrix_chars)]
        else
          line[i] = base_chars[math.random(#base_chars)]
        end
      end

      vim.api.nvim_echo({ { table.concat(line, ''), 'Normal' } }, false, {})
    end, delay * f)
  end

  local ok_flash_count = 3
  local ok_delay = 700

  for flash = 0, ok_flash_count - 1 do
    schedule(
      function()
        vim.api.nvim_echo({ { '0100111101001011', 'Normal' } }, false, {})
      end,
      end_delay * frames + flash * ok_delay * 2
    )

    schedule(
      function() vim.api.nvim_echo({ { '', 'Normal' } }, false, {}) end,
      end_delay * frames + flash * ok_delay * 2 + ok_delay
    )
  end

  schedule(
    function() vim.api.nvim_echo({ { '', 'Normal' } }, false, {}) end,
    end_delay * frames + ok_flash_count * ok_delay * 2 + 10
  )
end

pack.add {
  { src = 'https://github.com/windwp/nvim-autopairs' },
  { src = 'https://github.com/windwp/nvim-ts-autotag' },
  { src = 'https://github.com/numToStr/Comment.nvim' },
  { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
  { src = 'https://github.com/hrsh7th/nvim-cmp' },
  { src = 'https://github.com/hrsh7th/cmp-buffer' },
  { src = 'https://github.com/hrsh7th/cmp-path' },
  { src = 'https://github.com/stevearc/conform.nvim' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/habamax/vim-godot' },
  { src = 'https://github.com/skywind3000/asyncrun.vim' },
  { src = 'https://github.com/folke/snacks.nvim' },
  { src = 'https://github.com/teatek/gdscript-extended-lsp.nvim' },
  { src = 'https://github.com/mfussenegger/nvim-lint' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/folke/tokyonight.nvim' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
}

local tokyonight = require 'tokyonight'
tokyonight.setup {
  transparent = true,
  styles = {
    sidebars = 'transparent',
    floats = 'transparent',
  },
}
vim.cmd.colorscheme 'tokyonight'
vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'none', fg = '#a9b1d6' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'none', fg = '#5c6370' })
vim.api.nvim_set_hl(0, 'TabLineSel', { bg = 'none' })
vim.api.nvim_set_hl(0, 'MsgArea', { bg = 'none' })

vim.defer_fn(function()
  require('nvim-autopairs').setup {}

  require('nvim-ts-autotag').setup()

  require('Comment').setup {
    toggler = {
      line = 'gcc',
      block = 'gbc',
    },
    opleader = {
      line = 'gc',
      block = 'gb',
    },
    extra = {
      above = 'gcO',
      below = 'gco',
      eol = 'gcA',
    },
    mappings = {
      basic = true,
      extra = true,
    },
  }

  local cmp = require 'cmp'
  cmp.setup {
    completion = { completeopt = 'menu,menuone,noinsert' },
    mapping = cmp.mapping.preset.insert {
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<C-y>'] = cmp.mapping.confirm { select = true },
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'path' },
    },
  }

  local ft_formatters = {
    go = { 'goimports', 'gofumpt', 'gofmt' },
    python = { 'ruff' },
    lua = { 'stylua' },
    rust = { 'rustfmt' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    html = { 'prettier' },
    css = { 'prettier' },
    svelte = { 'prettier' },
    markdown = { 'mdformat-wrap' },
    java = { 'clang-format' },
    gdscript = { 'gdscript-format' },
  }

  local custom_formatters = {
    ['mdformat-wrap'] = {
      command = 'mdformat',
      args = { '--wrap', '80', '$FILENAME' },
      stdin = false,
    },
    ['gdscript-format'] = {
      command = 'gdscript-format',
    },
  }

  require('conform').setup {
    formatters_by_ft = ft_formatters,
    formatters = custom_formatters,
    format_after_save = {
      lsp_fallback = false,
      async = true,
      timeout_ms = 1000,
    },
  }

  require('gitsigns').setup {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  }

  local lint = require 'lint'
  local parser = require 'lint.parser'

  local custom_linters = {
    clippy = {
      cmd = 'cargo',
      stdin = false,
      args = { 'clippy', '--message-format', 'short' },
      stream = 'stderr',
      parser = parser.from_errorformat('%f:%l:%c: %m', {
        source = 'clippy',
        severity = vim.diagnostic.severity.WARN,
      }),
    },
    golangci_lint = {
      cmd = 'golangci-lint',
      stdin = false,
      args = { 'run', '--out-format', 'line-number' },
      stream = 'stdout',
      parser = parser.from_errorformat('%f:%l:%c: %m', {
        source = 'golangci_lint',
        severity = vim.diagnostic.severity.WARN,
      }),
    },
  }

  for name, def in pairs(custom_linters) do
    lint.linters[name] = def
  end

  local linters_by_ft = {
    python = { 'ruff' },
    javascript = { 'eslint' },
    typescript = { 'eslint' },
    html = { 'htmlhint' },
    css = { 'stylelint' },
    lua = { 'selene' },
  }

  lint.linters_by_ft = linters_by_ft

  local caps = require('cmp_nvim_lsp').default_capabilities()

  vim.diagnostic.config {
    float = { focusable = false, style = 'minimal', border = 'rounded' },
    signs = true,
    underline = true,
    update_in_insert = false,
    virtual_text = false,
  }

  vim.lsp.config.global = {
    capabilities = caps,
    inlay_hints = { enabled = false },
  }

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

  if vim.fn.executable 'make' == 1 then vim.fn.system 'make' end

  if vim.g.have_nerd_font then require('nvim-web-devicons').setup() end

  local telescope = require 'telescope'
  telescope.setup {
    extensions = {
      ['ui-select'] = require('telescope.themes').get_dropdown(),
    },
  }
  pcall(telescope.load_extension, 'fzf')
  pcall(telescope.load_extension, 'ui-select')

  vim.cmd 'silent! TSUpdate'
  require('nvim-treesitter').setup {
    ensure_installed = {
      'bash',
      'c',
      'cpp',
      'css',
      'go',
      'html',
      'javascript',
      'json',
      'lua',
      'python',
      'rust',
      'typescript',
      'tsx',
      'vim',
      'yaml',
      'svelte',
      'gdscript',
      'gdshader',
      'godot_resource',
    },
    highlight = { enable = true },
    indent = { enable = true },
  }

  require('snacks').setup {
    picker = {
      sources = {
        explorer = {
          exclude = { '*.uid', 'server.pipe' },
        },
      },
    },
  }

  require('gdscript-extended-lsp').setup {
    view_type = 'floating',
    picker = 'snacks',
  }

  loaded_animation()
end, 0)
