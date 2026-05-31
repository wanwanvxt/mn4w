if not vim.g.is_tty then
    local utils = require("my.utils")

    utils.lazy({
        name = "colorizer",
        packs = { utils.gh("norcalli/nvim-colorizer.lua") },
        cmd = "ColorizerToggle",
        config = function()
            require("colorizer").setup({}, {
                RGB      = true;
                RRGGBB   = true;
                names    = true;
                RRGGBBAA = true;
                rgb_fn   = true;
                hsl_fn   = true;
                mode     = "background";
            })
        end,
    })

    vim.keymap.set("n", "<leader>c", "<cmd>ColorizerToggle<cr>", { silent = true, desc = "toggle colorizer" })
end
