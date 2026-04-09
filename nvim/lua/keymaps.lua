local M = {}

local format = require 'conform'
local lint = require 'lint'

function M.set_lsp_keymaps(bufnr)
  local telescope = require 'telescope.builtin'
  vim.keymap.set(
    'n',
    'gd',
    telescope.lsp_definitions,
    { buffer = bufnr, desc = '[G]oto [D]efinition', silent = true }
  )

  vim.keymap.set(
    'n',
    'gr',
    telescope.lsp_references,
    { buffer = bufnr, desc = '[G]oto [R]eferences', silent = true }
  )

  vim.keymap.set(
    'n',
    'gI',
    telescope.lsp_implementations,
    { buffer = bufnr, desc = '[G]oto [I]mplementation', silent = true }
  )

  vim.keymap.set(
    'n',
    'gD',
    function() vim.lsp.buf.declaration() end,
    { buffer = bufnr, desc = '[G]oto [D]eclaration', silent = true }
  )

  vim.keymap.set(
    'n',
    '<leader>D',
    telescope.lsp_type_definitions,
    { buffer = bufnr, desc = 'Type [D]efinition', silent = true }
  )

  vim.keymap.set(
    'n',
    '<leader>ds',
    telescope.lsp_document_symbols,
    { buffer = bufnr, desc = '[D]ocument [S]ymbols', silent = true }
  )

  vim.keymap.set(
    'n',
    '<leader>ws',
    telescope.lsp_dynamic_workspace_symbols,
    { buffer = bufnr, desc = '[W]orkspace [S]ymbols', silent = true }
  )

  vim.keymap.set(
    'n',
    '<leader>rn',
    function() vim.lsp.buf.rename() end,
    { buffer = bufnr, desc = '[R]e[n]ame', silent = true }
  )

  vim.keymap.set(
    'n',
    '<leader>ca',
    function() vim.lsp.buf.code_action() end,
    { buffer = bufnr, desc = '[C]ode [A]ction', silent = true }
  )

  vim.keymap.set('n', 'K', function()
    if vim.lsp.buf.server_ready() then
      vim.lsp.buf.hover()
    else
      vim.cmd 'normal! K'
    end
  end, { buffer = bufnr, desc = 'Hover Documentation', silent = true })

  vim.keymap.set(
    'n',
    ']d',
    function() vim.diagnostic.goto_next { float = true } end,
    { desc = 'Next [D]iagnostic', silent = true }
  )

  vim.keymap.set(
    'n',
    '[d',
    function() vim.diagnostic.goto_prev { float = true } end,
    { desc = 'Previous [D]iagnostic', silent = true }
  )

  vim.keymap.set(
    'n',
    ']q',
    '<cmd>cnext<CR>',
    { desc = 'Next quickfix', silent = true }
  )

  vim.keymap.set(
    'n',
    '[q',
    '<cmd>cprev<CR>',
    { desc = 'Prev quickfix', silent = true }
  )

  vim.keymap.set(
    'n',
    ']l',
    '<cmd>lnext<CR>',
    { desc = 'Next location', silent = true }
  )

  vim.keymap.set(
    'n',
    '[l',
    '<cmd>lprev<CR>',
    { desc = 'Prev location', silent = true }
  )

  vim.keymap.set(
    'n',
    '<leader>cd',
    vim.diagnostic.open_float,
    { buffer = bufnr, desc = 'Show [C]ode [D]iagnostics', silent = true }
  )

  vim.keymap.set('n', '<leader>h', function()
    local bufnr = vim.api.nvim_get_current_buf()
    local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
    vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
  end, { desc = 'Toggle Inlay [H]ints', silent = true })
end

function M.set_general_keymaps()
  vim.keymap.set(
    'n',
    '<leader>e',
    '<cmd>Explore<CR>',
    { desc = '[E]xplore the current directory', silent = true }
  )

  vim.keymap.set(
    'n',
    '<leader>n',
    '<cmd>bnext<CR>',
    { desc = 'Go to the [N]ext buffer', silent = true }
  )

  vim.keymap.set(
    'n',
    '<leader>p',
    '<cmd>bprevious<CR>',
    { desc = 'Go to the [P]revious buffer', silent = true }
  )

  vim.keymap.set(
    'n',
    '<leader>d',
    '<cmd>bdelete<CR>',
    { desc = '[D]elete the active buffer', silent = true }
  )

  vim.keymap.set(
    'n',
    '<leader>a',
    function()
      vim.cmd('bufdo if bufnr() != ' .. vim.fn.bufnr '%' .. ' | bd | endif')
    end,
    { desc = 'Delete all but active buffer', silent = true }
  )

  vim.keymap.set(
    'n',
    '<Esc>',
    function() vim.cmd 'nohlsearch' end,
    { silent = true }
  )

  vim.keymap.set(
    'n',
    '<leader>f',
    function() format.format { async = true, lsp_fallback = true } end,
    { desc = '[F]ormat Buffer', silent = true }
  )

  vim.keymap.set(
    'n',
    '<leader>l',
    function() lint.try_lint() end,
    { desc = '[L]int Buffer', silent = true }
  )
end

function M.set_telescope_keymaps()
  vim.keymap.set(
    'n',
    '<leader>sh',
    telescope.help_tags,
    { desc = '[S]earch [H]elp', silent = true }
  )

  vim.keymap.set(
    'n',
    '<leader>sk',
    telescope.keymaps,
    { desc = '[S]earch [K]eymaps', silent = true }
  )

  vim.keymap.set(
    'n',
    '<leader>sf',
    telescope.find_files,
    { desc = '[S]earch [F]iles', silent = true }
  )

  vim.keymap.set(
    'n',
    '<leader>ss',
    telescope.builtin,
    { desc = '[S]earch [S]elect Telescope', silent = true }
  )

  vim.keymap.set(
    'n',
    '<leader>sw',
    telescope.grep_string,
    { desc = '[S]earch current [W]ord', silent = true }
  )

  vim.keymap.set(
    'n',
    '<leader>sg',
    telescope.live_grep,
    { desc = '[S]earch by [G]rep', silent = true }
  )

  vim.keymap.set(
    'n',
    '<leader>sd',
    telescope.diagnostics,
    { desc = '[S]earch [D]iagnostics', silent = true }
  )

  vim.keymap.set(
    'n',
    '<leader>sr',
    telescope.resume,
    { desc = '[S]earch [R]esume', silent = true }
  )

  vim.keymap.set('n', '<leader>s.', telescope.oldfiles, {
    desc = "[S]earch Recent Files ('.' for repeat)",
    silent = true,
  })

  vim.keymap.set(
    'n',
    '<leader><leader>',
    telescope.buffers,
    { desc = '[ ] Find existing buffers', silent = true }
  )

  vim.keymap.set(
    'n',
    '<leader>/',
    function()
      telescope.current_buffer_fuzzy_find(
        require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        }
      )
    end,
    {
      desc = '[/] Fuzzily search in current buffer',
      silent = true,
    }
  )

  vim.keymap.set(
    'n',
    '<leader>s/',
    function()
      telescope.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end,
    { desc = '[S]earch [/] in Open Files', silent = true }
  )

  vim.keymap.set(
    'n',
    '<leader>sn',
    function() telescope.find_files { cwd = vim.fn.stdpath 'config' } end,
    { desc = '[S]earch [N]eovim files', silent = true }
  )
end

return M
