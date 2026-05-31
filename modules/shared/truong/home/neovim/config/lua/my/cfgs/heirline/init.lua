local utils = require("my.utils")

utils.lazy({
    name = "heirline",
    packs = {{ src = utils.gh("rebelot/heirline.nvim"), version = "stable" }},
    event = "UIEnter",
    config = function()
        local colors = function()
            local hl_utils = require("heirline.utils")

            return {
                bright_bg = hl_utils.get_highlight("Folded").bg,
                bright_fg = hl_utils.get_highlight("Folded").fg,
                fg        = hl_utils.get_highlight("Normal").fg,
                bg        = hl_utils.get_highlight("Normal").bg,

                red    = hl_utils.get_highlight("PreProc").fg,
                green  = hl_utils.get_highlight("String").fg,
                yellow = hl_utils.get_highlight("Constant").fg,
                blue   = hl_utils.get_highlight("Function").fg,
                purple = hl_utils.get_highlight("Statement").fg,
                cyan   = hl_utils.get_highlight("Type").fg,
                gray   = hl_utils.get_highlight("NonText").fg,

                diag_warn  = hl_utils.get_highlight("DiagnosticWarn").fg,
                diag_error = hl_utils.get_highlight("DiagnosticError").fg,
                diag_info  = hl_utils.get_highlight("DiagnosticInfo").fg,
                diag_hint  = hl_utils.get_highlight("DiagnosticHint").fg,

                git_del    = hl_utils.get_highlight("diffDeleted").fg,
                git_add    = hl_utils.get_highlight("diffAdded").fg,
                git_change = hl_utils.get_highlight("diffChanged").fg,
            }
        end

        require("heirline").setup({
            statusline = require("plugins.heirline.statusline"),
            tabline = require("plugins.heirline.tabline"),
            opts = {
                colors = colors,
            }
        })

        vim.api.nvim_create_autocmd({ "ColorScheme", "Signal" }, {
            group = vim.api.nvim_create_augroup("Heirline", { clear = true }),
            pattern = { "*", "SIGUSR1" },
            callback = function()
                require("heirline.utils").on_colorscheme(colors)
            end,
        })
    end,
})
