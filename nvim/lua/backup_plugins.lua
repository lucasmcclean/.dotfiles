local pack = vim.pack

pack.add({
  'windwp/nvim-autopairs',
  type = 'start',
  post = function() require('nvim-autopairs').setup {} end,
})

pack.add({
  'windwp/nvim-ts-autotag',
  type = 'start',
  post = function() require('nvim-ts-autotag').setup() end,
})

pack.add({
  'numToStr/Comment.nvim',
  type = 'start',
  post = function()
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
  end,
})

pack.add({'hrsh7th/cmp-nvim-lsp', type = 'start' })

pack.add({
  'hrsh7th/nvim-cmp',
  type = 'start',
  post = function()
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
  end,
})

pack.add({
  'stevearc/conform.nvim',
  type = 'start',
  post = function()
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
  end,
})

pack.add({
  'lewis6991/gitsigns.nvim',
  type = 'start',
  post = function()
    require('gitsigns').setup {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    }
  end,
})

pack.add({'habamax/vim-godot', type = 'start' })

pack.add({'skywind3000/asyncrun.vim', type = 'start' })

pack.add({
  'folke/snacks.nvim',
  type = 'start',
  post = function()
    require('snacks').setup {
      picker = {
        sources = {
          explorer = {
            exclude = { '*.uid', 'server.pipe' },
          },
        },
      },
    }
  end,
})

pack.add({
  'teatek/gdscript-extended-lsp.nvim',
  type = 'start',
  post = function()
    require('gdscript-extended-lsp').setup {
      view_type = 'floating',
      picker = 'snacks',
    }
  end,
})

pack.add({
  'mfussenegger/nvim-lint',
  type = 'start',
  post = function()
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
      source = 'golangci-lint',
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
  end,
})

pack.add({
  'neovim/nvim-lspconfig',
  type = 'start',
  post = function()
    local lspconfig = require 'lspconfig'
    local caps = require('cmp_nvim_lsp').default_capabilities()

    local function setup_server(name, opts)
      opts = opts or {}
      opts.capabilities = caps
      opts.flags = opts.flags or { debounce_text_changes = 150 }

      lspconfig[name].setup(opts)
    end

    setup_server('ltex_plus', {
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
    })

    setup_server('lua', {
      cmd = { 'lua-language-server' },
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } },
          workspace = { library = vim.api.nvim_get_runtime_file('', true) },
        },
      },
      filetypes = { 'lua' },
    })

    setup_server('jdtls', {
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
      root_dir = lspconfig.util.root_pattern(
        '.git',
        'mvnw',
        'gradlew',
        'pom.xml',
        'build.gradle'
      )(vim.fn.getcwd()) or vim.fn.getcwd(),
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
    })

    setup_server('rust_analyzer', {
      settings = {
        ['rust-analyzer'] = {
          checkOnSave = true,
          check = { command = 'clippy' },
        },
      },
    })

    setup_server('asm_lsp', {
      root_dir = lspconfig.util.root_pattern('.asm-lsp.toml', '.git'),
    })

    local simple_servers = {
      'pylsp',
      'gopls',
      'tsserver',
      'html',
      'cssls',
      'svelte',
      'bashls',
      'jsonls',
      'dockerls',
      'marksman',
      'clangd',
      'gdscript',
    }

    for _, srv in ipairs(simple_servers) do
      setup_server(srv)
    end
  end,
})

pack.add({'nvim-lua/plenary.nvim', type = 'start' })

pack.add({
  'nvim-telescope/telescope-fzf-native.nvim',
  type = 'start',
  post = function()
    if vim.fn.executable 'make' == 1 then vim.fn.system 'make' end
  end,
})

pack.add({'nvim-telescope/telescope-ui-select.nvim', type = 'start' })

pack.add({
  'nvim-tree/nvim-web-devicons',
  type = 'start',
  post = function()
    if vim.g.have_nerd_font then require('nvim-web-devicons').setup() end
  end,
})

pack.add({
  'nvim-telescope/telescope.nvim',
  type = 'start',
  post = function()
    local telescope = require 'telescope'
    telescope.setup {
      extensions = {
        ['ui-select'] = require('telescope.themes').get_dropdown(),
      },
    }

    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'ui-select')
  end,
})

pack.add({
  'folke/tokyonight.nvim',
  type = 'start',
  post = function()
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
  end,
})

pack.add({
  'nvim-treesitter/nvim-treesitter',
  type = 'start',
  post = function()
    vim.cmd 'TSUpdate'

    local treesitter = require 'nvim-treesitter.configs'
    treesitter.setup {
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
      -- textobjects = {
      --   select = {
      --     enable = true,
      --     lookahead = true,
      --     keymaps = {
      --       ["af"] = "@function.outer",
      --       ["if"] = "@function.inner",
      --       ["ac"] = "@class.outer",
      --       ["ic"] = "@class.inner",
      --       ["al"] = "@loop.outer",
      --       ["il"] = "@loop.inner",
      --       ["ad"] = "@conditional.outer",
      --       ["id"] = "@conditional.inner",
      --     },
      --   },
      --   move = {
      --     enable = true,
      --     set_jumps = true,
      --     goto_next_start = {
      --       ["]m"] = "@function.outer",
      --       ["]c"] = "@class.outer",
      --     },
      --     goto_previous_start = {
      --       ["[m"] = "@function.outer",
      --       ["[c"] = "@class.outer",
      --     },
      --   },
      --   swap = {
      --     enable = true,
      --     swap_next = {
      --       ["<leader>sn"] = "@parameter.inner",
      --     },
      --     swap_previous = {
      --       ["<leader>sp"] = "@parameter.inner",
      --     },
      --   },
      -- },
    }
  end,
})
