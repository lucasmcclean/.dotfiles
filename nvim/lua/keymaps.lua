local M = {}

function M.set_lsp_keymaps(bufnr)
  local function packadd_telescope()
    vim.cmd.packadd 'telescope.nvim'
    vim.cmd.packadd 'telescope-fzf-native.nvim'
    vim.cmd.packadd 'plenary.nvim'
    return require 'telescope.builtin'
  end

  vim.keymap.set('n', 'gd', function()
    packadd_telescope().lsp_definitions()
  end, { buffer = bufnr, desc = '[G]oto [D]efinition', silent = true })
  vim.keymap.set('n', 'gr', function()
    packadd_telescope().lsp_references()
  end, { buffer = bufnr, desc = '[G]oto [R]eferences', silent = true })
  vim.keymap.set('n', 'gI', function()
    packadd_telescope().lsp_implementations()
  end, { buffer = bufnr, desc = '[G]oto [I]mplementation', silent = true })
  vim.keymap.set('n', 'gD', function()
    vim.lsp.buf.declaration()
  end, { buffer = bufnr, desc = '[G]oto [D]eclaration', silent = true })
  vim.keymap.set('n', '<leader>D', function()
    packadd_telescope().lsp_type_definitions()
  end, { buffer = bufnr, desc = 'Type [D]efinition', silent = true })
  vim.keymap.set('n', '<leader>ds', function()
    packadd_telescope().lsp_document_symbols()
  end, { buffer = bufnr, desc = '[D]ocument [S]ymbols', silent = true })
  vim.keymap.set('n', '<leader>ws', function()
    packadd_telescope().lsp_dynamic_workspace_symbols()
  end, { buffer = bufnr, desc = '[W]orkspace [S]ymbols', silent = true })
  vim.keymap.set('n', '<leader>rn', function()
    vim.lsp.buf.rename()
  end, { buffer = bufnr, desc = '[R]e[n]ame', silent = true })
  vim.keymap.set('n', '<leader>ca', function()
    vim.lsp.buf.code_action()
  end, { buffer = bufnr, desc = '[C]ode [A]ction', silent = true })

  vim.keymap.set('n', 'K', function()
    local all_ready = true
    local clients = vim.lsp.get_clients { bufnr = 0 }
    for _, client in ipairs(clients) do
      if not client.initialized then
        all_ready = false
        break
      end
    end
    if all_ready and #clients > 0 then
      vim.lsp.buf.hover()
    else
      vim.cmd 'normal! K'
    end
  end, { buffer = bufnr, desc = 'Hover Documentation', silent = true })

  vim.keymap.set('n', ']d', function()
    vim.diagnostic.jump { count = 1, float = true }
  end, { desc = 'Next [D]iagnostic', silent = true })
  vim.keymap.set('n', '[d', function()
    vim.diagnostic.jump { count = -1, float = true }
  end, { desc = 'Previous [D]iagnostic', silent = true })

  local function show_or_copy_diagnostic()
    local bufnr = 0
    local line_diag = vim.diagnostic.get(bufnr, { lnum = vim.fn.line '.' - 1 })
    if #line_diag == 0 then
      print 'No diagnostics on this line'
      return
    end
    local msg = table.concat(
      vim.tbl_map(function(d)
        return d.message
      end, line_diag),
      '\n'
    )
    vim.ui.select(
      { 'Copy Message', 'Open in Buffer' },
      { prompt = 'Diagnostic action: ' },
      function(choice)
        if choice == 'Open in Buffer' then
          local buf = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(msg, '\n'))
          vim.api.nvim_buf_set_option(buf, 'bufhidden', 'wipe')
          vim.api.nvim_buf_set_option(buf, 'filetype', 'text')
          vim.api.nvim_command 'split'
          vim.api.nvim_win_set_buf(0, buf)
        elseif choice == 'Copy Message' then
          vim.fn.setreg('+', msg)
          print 'Diagnostic copied to clipboard'
        end
      end
    )
  end

  vim.keymap.set(
    'n',
    '<leader>cd',
    show_or_copy_diagnostic,
    { desc = 'Open/[C]opy [D]iagnostic', silent = true }
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
    '<leader>dd',
    vim.diagnostic.open_float,
    { buffer = bufnr, desc = '[D]isplay code [D]iagnostics', silent = true }
  )
  vim.keymap.set('n', '<leader>h', function()
    local bufnr = vim.api.nvim_get_current_buf()
    local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
    vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
  end, { desc = 'Toggle Inlay [H]ints', silent = true })
  vim.keymap.set('n', '<leader>v', function()
    local cfg = vim.diagnostic.config()
    local enabled = cfg.virtual_text ~= false
    if enabled then
      vim.diagnostic.config { virtual_text = false }
    else
      vim.diagnostic.config { virtual_text = { spacing = 4, prefix = '●' } }
    end
  end, { desc = 'Toggle [V]irtual Text', silent = true })
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
  vim.keymap.set('n', '<leader>a', function()
    vim.cmd('bufdo if bufnr() != ' .. vim.fn.bufnr '%' .. ' | bd | endif')
  end, { desc = 'Delete all but active buffer', silent = true })
  vim.keymap.set('n', '<Esc>', function()
    vim.cmd 'nohlsearch'
  end, { silent = true })
  vim.keymap.set(
    'n',
    '<leader>cm',
    ':delmarks a-z<CR>',
    { desc = '[C]lear [M]arks', silent = true }
  )
end

return M
