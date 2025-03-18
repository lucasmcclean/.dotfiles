local M = {}

function M.set_lsp_keymaps(bufnr)
  local telescope = require("telescope.builtin")

  vim.keymap.set("n", "gd", telescope.lsp_definitions,
    { buffer = bufnr, desc = "LSP: [G]oto [D]efinition", silent = true })
  vim.keymap.set("n", "gr", telescope.lsp_references,
    { buffer = bufnr, desc = "LSP: [G]oto [R]eferences", silent = true })
  vim.keymap.set("n", "gI", telescope.lsp_implementations,
    { buffer = bufnr, desc = "LSP: [G]oto [I]mplementation", silent = true })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration,
    { buffer = bufnr, desc = "LSP: [G]oto [D]eclaration", silent = true })
  vim.keymap.set("n", "<leader>D", telescope.lsp_type_definitions,
    { buffer = bufnr, desc = "LSP: Type [D]efinition", silent = true })
  vim.keymap.set("n", "<leader>ds", telescope.lsp_document_symbols,
    { buffer = bufnr, desc = "LSP: [D]ocument [S]ymbols", silent = true })
  vim.keymap.set("n", "<leader>ws", telescope.lsp_dynamic_workspace_symbols,
    { buffer = bufnr, desc = "LSP: [W]orkspace [S]ymbols", silent = true })
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,
    { buffer = bufnr, desc = "LSP: [R]e[n]ame", silent = true })
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,
    { buffer = bufnr, desc = "LSP: [C]ode [A]ction", silent = true })
  vim.keymap.set("n", "K", vim.lsp.buf.hover,
    { buffer = bufnr, desc = "LSP: Hover Documentation", silent = true })
  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, { buffer = bufnr, desc = "[F]ormat Document", silent = true })

  if vim.lsp.inlay_hint and vim.lsp.buf.inlay_hint then
    vim.keymap.set("n", "<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { buffer = bufnr, desc = "[T]oggle Inlay [H]ints", silent = true })
  end
end

return M
