vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.cmd.packadd 'nvim-cmp'
    vim.cmd.packadd 'cmp-nvim-lsp'
    vim.cmd.packadd 'cmp-buffer'
    vim.cmd.packadd 'cmp-path'
    vim.cmd.packadd 'nvim-lspconfig'

    local cmp = require 'cmp'
    local cmp_nvim_lsp = require 'cmp_nvim_lsp'

    local caps = cmp_nvim_lsp.default_capabilities()

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
  once = true,
})

