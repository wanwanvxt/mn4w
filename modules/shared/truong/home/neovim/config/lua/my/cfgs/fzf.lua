local utils = require("my.utils")

utils.lazy({
    name = "fzf",
    packs = { utils.gh("ibhagwan/fzf-lua") },
    cmd = "FzfLua",
    config = function()
        require("fzf-lua").setup()
    end,
})

vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>",     { silent = true, desc = "fzf files" })
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", { silent = true, desc = "fzf live grep" })
