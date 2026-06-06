local utils = require("my.utils")

utils.lazy({
    name = "which-key",
    packs = { utils.gh("Cassin01/wf.nvim") },
    event = "UIEnter",
    config = function()
        require("wf").setup()

        local which_key = require("wf.builtin.which_key")
        vim.keymap.set("n", "<leader>", which_key({ text_insert_in_advance = "<leader>" }), { desc = "which-key" })
    end,
})
