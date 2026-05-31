local utils = require("my.utils")

utils.lazy({
    name = "treesitter",
    packs = { utils.gh("romus204/tree-sitter-manager.nvim") },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "TSManager",
    config = function()
        require("tree-sitter-manager").setup({
            auto_install = false,
            highlight = true,
        })

        vim.keymap.set("n", "<leader>t", "<cmd>TSManager<cr>", { silent = true, desc = "open treesitter manager" })
    end,
})
