local M = {}

function M.set_keymaps(bufnr)
	local telescope = require("telescope.builtin")
	local lint = require("lint")
	local format = require("conform")

	-- Telescope
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

	-- Format
	vim.keymap.set("n", "<leader>f", function()
		format.format({ async = true, lsp_fallback = true })
	end, { buffer = bufnr, desc = "[F]ormat Buffer" })
	vim.keymap.set("n", "<leader>fw", function()
		format.format({ async = true, lsp_fallback = true })
	end, { desc = "[F]ormat [W]orkspace" })

	-- Lint
	vim.keymap.set("n", "<leader>l", function()
		lint.try_lint()
	end, { buffer = bufnr, desc = "[L]int Buffer" })
	vim.keymap.set("n", "<leader>lw", function()
		lint.try_lint()
	end, { desc = "[L]int [W]orkspace" })

	-- LSP
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP: [R]e[n]ame", silent = true })
	vim.keymap.set(
		"n",
		"<leader>ca",
		vim.lsp.buf.code_action,
		{ buffer = bufnr, desc = "LSP: [C]ode [A]ction", silent = true }
	)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP: Hover Documentation", silent = true })

	-- Diagnostics
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous [D]iagnostic" })
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next [D]iagnostic" })
	vim.keymap.set(
		"n",
		"<leader>cd",
		vim.diagnostic.open_float,
		{ buffer = bufnr, desc = "Show [C]ode [D]iagnostics", silent = true }
	)

	-- Misc
	if vim.lsp.inlay_hint and vim.lsp.buf.inlay_hint then
		vim.keymap.set("n", "<leader>h", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, { desc = "[T]oggle Inlay [H]ints", silent = true })
	end
end

return M
