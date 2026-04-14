local telescope = require 'telescope'

telescope.setup {
  extensions = {
    ['ui-select'] = require('telescope.themes').get_dropdown(),
  },
}

pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'ui-select')

local builtin = require 'telescope.builtin'

local function telescope_keymap(lhs, fn, desc)
  vim.keymap.set('n', lhs, function()
    vim.cmd.packadd 'telescope.nvim'
    vim.cmd.packadd 'telescope-fzf-native.nvim'
    vim.cmd.packadd 'telescope-ui-select.nvim'
    vim.cmd.packadd 'plenary.nvim'
    fn()
  end, { desc = desc, silent = true })
end

telescope_keymap('<leader>sh', builtin.help_tags, '[S]earch [H]elp')
telescope_keymap('<leader>sk', builtin.keymaps, '[S]earch [K]eymaps')
telescope_keymap('<leader>sf', builtin.find_files, '[S]earch [F]iles')
telescope_keymap('<leader>ss', builtin.builtin, '[S]earch [S]elect Telescope')
telescope_keymap('<leader>sw', builtin.grep_string, '[S]earch current [W]ord')
telescope_keymap('<leader>sg', builtin.live_grep, '[S]earch by [G]rep')
telescope_keymap('<leader>sd', builtin.diagnostics, '[S]earch [D]iagnostics')
telescope_keymap('<leader>sr', builtin.resume, '[S]earch [R]esume')
telescope_keymap(
  '<leader>s.',
  builtin.oldfiles,
  "[S]earch Recent Files ('.' for repeat)"
)
telescope_keymap(
  '<leader><leader>',
  builtin.buffers,
  '[ ] Find existing buffers'
)
telescope_keymap('/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, '[/] Fuzzily search in current buffer')
telescope_keymap('<leader>s/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, '[S]earch [/] in Open Files')
telescope_keymap('<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, '[S]earch [N]eovim files')
telescope_keymap('<leader>m', builtin.marks, '[M]arks')

