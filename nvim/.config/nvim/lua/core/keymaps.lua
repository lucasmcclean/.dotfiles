local M = {}

local format = require("conform")
local lint = require("lint")
local telescope = require("telescope.builtin")

function M.set_lsp_keymaps(bufnr)
  vim.keymap.set(
    "n",
    "gd",
    telescope.lsp_definitions,
    { buffer = bufnr, desc = "LSP: [G]oto [D]efinition", silent = true }
  )
  vim.keymap.set(
    "n",
    "gr",
    telescope.lsp_references,
    { buffer = bufnr, desc = "LSP: [G]oto [R]eferences", silent = true }
  )
  vim.keymap.set(
    "n",
    "gI",
    telescope.lsp_implementations,
    { buffer = bufnr, desc = "LSP: [G]oto [I]mplementation", silent = true }
  )
  vim.keymap.set(
    "n",
    "gD",
    vim.lsp.buf.declaration,
    { buffer = bufnr, desc = "LSP: [G]oto [D]eclaration", silent = true }
  )
  vim.keymap.set(
    "n",
    "<leader>D",
    telescope.lsp_type_definitions,
    { buffer = bufnr, desc = "LSP: Type [D]efinition", silent = true }
  )
  vim.keymap.set(
    "n",
    "<leader>ds",
    telescope.lsp_document_symbols,
    { buffer = bufnr, desc = "LSP: [D]ocument [S]ymbols", silent = true }
  )
  vim.keymap.set(
    "n",
    "<leader>ws",
    telescope.lsp_dynamic_workspace_symbols,
    { buffer = bufnr, desc = "LSP: [W]orkspace [S]ymbols", silent = true }
  )

  vim.keymap.set(
    "n",
    "<leader>rn",
    vim.lsp.buf.rename,
    { buffer = bufnr, desc = "LSP: [R]e[n]ame", silent = true }
  )
  vim.keymap.set(
    "n",
    "<leader>ca",
    vim.lsp.buf.code_action,
    { buffer = bufnr, desc = "LSP: [C]ode [A]ction", silent = true }
  )
  vim.keymap.set(
    "n",
    "K",
    vim.lsp.buf.hover,
    { buffer = bufnr, desc = "LSP: Hover Documentation", silent = true }
  )

  vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, {
    desc = "Next [D]iagnostic",
    noremap = true,
    silent = true,
  })

  vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, {
    desc = "Previous [D]iagnostic",
    noremap = true,
    silent = true,
  })

  vim.keymap.set(
    "n",
    "<leader>cd",
    vim.diagnostic.open_float,
    { buffer = bufnr, desc = "Show [C]ode [D]iagnostics", silent = true }
  )

  if vim.lsp.inlay_hint and vim.lsp.buf.inlay_hint then
    vim.keymap.set("n", "<leader>h", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = "[T]oggle Inlay [H]ints", silent = true })
  end
end

function M.set_general_keymaps()
  vim.keymap.set(
    "n",
    "<leader>e",
    "<cmd>Explore<CR>",
    { desc = "[E]xplore the current directory", noremap = true, silent = true }
  )
  vim.keymap.set(
    "n",
    "<leader>n",
    "<cmd>bnext<CR>",
    { desc = "Go to the [N]ext buffer", noremap = true, silent = true }
  )
  vim.keymap.set(
    "n",
    "<leader>d",
    "<cmd>bdelete<CR>",
    { desc = "[D]elete the active buffer", noremap = true, silent = true }
  )
  vim.keymap.set(
    "n",
    "<leader>p",
    "<cmd>bprevious<CR>",
    { desc = "Go to the [P]revious buffer", noremap = true, silent = true }
  )
  vim.keymap.set("n", "<leader>a", "<cmd>%bd|e#|bd#<CR>", {
    desc = "Delete all but the [A]ctive buffer",
    noremap = true,
    silent = true,
  })

  vim.keymap.set(
    "n",
    "<Esc>",
    ":nohlsearch<CR>",
    { noremap = true, silent = true }
  )

  vim.keymap.set("n", "<leader>f", function()
    format.format({ async = true, lsp_fallback = true })
  end, { desc = "[F]ormat Buffer", noremap = true, silent = true })

  vim.keymap.set("n", "<leader>fw", function()
    format.format({ async = true, lsp_fallback = true })
  end, { desc = "[F]ormat [W]orkspace", noremap = true, silent = true })

  vim.keymap.set("n", "<leader>l", function()
    lint.try_lint()
  end, { desc = "[L]int Buffer", noremap = true, silent = true })

  vim.keymap.set("n", "<leader>lw", function()
    lint.try_lint()
  end, { desc = "[L]int [W]orkspace", noremap = true, silent = true })
end

function M.set_telescope_keymaps()
  vim.keymap.set(
    "n",
    "<leader>sh",
    telescope.help_tags,
    { desc = "[S]earch [H]elp", noremap = true, silent = true }
  )
  vim.keymap.set(
    "n",
    "<leader>sk",
    telescope.keymaps,
    { desc = "[S]earch [K]eymaps", noremap = true, silent = true }
  )
  vim.keymap.set(
    "n",
    "<leader>sf",
    telescope.find_files,
    { desc = "[S]earch [F]iles", noremap = true, silent = true }
  )
  vim.keymap.set(
    "n",
    "<leader>ss",
    telescope.builtin,
    { desc = "[S]earch [S]elect Telescope", noremap = true, silent = true }
  )
  vim.keymap.set(
    "n",
    "<leader>sw",
    telescope.grep_string,
    { desc = "[S]earch current [W]ord", noremap = true, silent = true }
  )
  vim.keymap.set(
    "n",
    "<leader>sg",
    telescope.live_grep,
    { desc = "[S]earch by [G]rep", noremap = true, silent = true }
  )
  vim.keymap.set(
    "n",
    "<leader>sd",
    telescope.diagnostics,
    { desc = "[S]earch [D]iagnostics", noremap = true, silent = true }
  )
  vim.keymap.set(
    "n",
    "<leader>sr",
    telescope.resume,
    { desc = "[S]earch [R]esume", noremap = true, silent = true }
  )
  vim.keymap.set("n", "<leader>s.", telescope.oldfiles, {
    desc = "[S]earch Recent Files ('.' for repeat)",
    noremap = true,
    silent = true,
  })
  vim.keymap.set(
    "n",
    "<leader><leader>",
    telescope.buffers,
    { desc = "[ ] Find existing buffers", noremap = true, silent = true }
  )

  vim.keymap.set("n", "<leader>/", function()
    telescope.current_buffer_fuzzy_find(
      require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      })
    )
  end, {
    desc = "[/] Fuzzily search in current buffer",
    noremap = true,
    silent = true,
  })

  vim.keymap.set("n", "<leader>s/", function()
    telescope.live_grep({
      grep_open_files = true,
      prompt_title = "Live Grep in Open Files",
    })
  end, { desc = "[S]earch [/] in Open Files", noremap = true, silent = true })

  vim.keymap.set("n", "<leader>sn", function()
    telescope.find_files({ cwd = vim.fn.stdpath("config") })
  end, { desc = "[S]earch [N]eovim files", noremap = true, silent = true })
end

return M
