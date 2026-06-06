if not vim.g.is_tty then
    local utils = require("my.utils")
    vim.pack.add({ utils.gh("nvim-mini/mini.icons") })

    local mi = require("mini.icons")
    mi.setup()
    mi.mock_nvim_web_devicons()
end
