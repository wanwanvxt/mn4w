if not vim.g.is_tty then
    local utils = require("my.utils")

    utils.lazy({
        name = "virt-column",
        packs = { utils.gh("lukas-reineke/virt-column.nvim") },
        event = "BufWinEnter",
        config = function()
            require("virt-column").setup({
                char = "▕",
            })
        end,
    })
end
