local utils = require("utils")

utils.lazy({
    name = "autoclose",
    packs = { utils.gh("m4xshen/autoclose.nvim") },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
        require("autoclose").setup()
        vim.opt.smartindent = false
        vim.opt.cindent = false
    end,
})
