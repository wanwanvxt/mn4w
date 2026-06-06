vim.keymap.set("n", "<leader>w", "<cmd>update<cr>", { silent = true, desc = "save buffer" })
vim.keymap.set("n", "<leader>q", "<cmd>x<cr>",      { silent = true, desc = "quit current window" })
vim.keymap.set("n", "<leader>Q", "<cmd>qa!<cr>",    { silent = true, desc = "quit nvim" })
vim.keymap.set("t", "<Esc>",     [[<c-\><c-n>]])

vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "H", "^",  { silent = true, desc = "goto start of line" })
vim.keymap.set({ "n", "x" }, "L", "g_", { silent = true, desc = "goto end of line" })
vim.keymap.set("i", "<C-A>", "<HOME>",  { silent = true })
vim.keymap.set("i", "<C-E>", "<END>",   { silent = true })

-- continuous visual shifting
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")
