local utils = require("utils")

utils.lazy({
    name = "treesitter",
    packs = { utils.gh("romus204/tree-sitter-manager.nvim") },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "TSManager",
    config = function()
        require("tree-sitter-manager").setup({
            languages = {
                rhai = {
                    install_info = {
                        url = "https://github.com/elkowar/tree-sitter-rhai",
                        use_repo_queries = true,
                    },
                },
            },
        })
    end,
})

vim.keymap.set("n", "<leader>t", "<cmd>TSManager<cr>", { silent = true, desc = "open treesitter manager" })
