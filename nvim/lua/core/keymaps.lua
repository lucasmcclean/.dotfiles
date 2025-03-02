-- Buffer Management & Navigation
vim.keymap.set("n", "<leader>e", "<cmd>Explore<CR>", { desc = "[E]xplore the current directory" })

vim.keymap.set("n", "<leader>n", "<cmd>bnext<CR>", { desc = "Go to the [N]ext buffer" })
vim.keymap.set("n", "<leader>d", "<cmd>bdelete<CR>", { desc = "[D]elete the active buffer" })
vim.keymap.set("n", "<leader>p", "<cmd>bprevious<CR>", { desc = "Go to the [P]revious buffer" })
vim.keymap.set("n", "<leader>a", "<cmd>b#<CR>", { desc = "Delete all but the [A]ctive buffer" })

-- Telescope
vim.keymap.set(
	"n",
	"<leader>fs",
	"<cmd>Telescope live_grep<CR>",
	{ desc = "[F]ind [S]tring", noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<leader>ff",
	"<cmd>Telescope find_files<CR>",
	{ desc = "[F]ind [F]ile", noremap = true, silent = true }
)

-- Clipboard
vim.keymap.set("n", "d", '"_d')
vim.keymap.set("n", "c", '"_c')

-- Language
vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", { noremap = true, silent = true })
