-- Buffer Management & Navigation
vim.keymap.set("n", "<leader>e", "<cmd>Explore<CR>",
  { desc = "[E]xplore the current directory" })

vim.keymap.set("n", "<leader>n", "<cmd>bnext<CR>",
  { desc = "Go to the [N]ext buffer" })
vim.keymap.set("n", "<leader>d", "<cmd>bdelete<CR>",
  { desc = "[D]elete the active buffer" })
vim.keymap.set("n", "<leader>p", "<cmd>bprevious<CR>",
  { desc = "Go to the [P]revious buffer" })
vim.keymap.set("n", "<leader>a", "<cmd>%bd|e#|bd#<CR>",
  { desc = "Delete all but the [A]ctive buffer" })

-- Search
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>",
  { noremap = true, silent = true })
