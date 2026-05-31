if not vim.g.is_tty then
    local utils = require("my.utils")
    vim.pack.add({ utils.gh("rebelot/kanagawa.nvim") })

    -- config
    local set_colorscheme = function()
        local chameleon = vim.fn.stdpath("config") .. "/lua/my/chameleon.lua"
        local colors = dofile(chameleon)

        require("kanagawa").setup({
            colors = {
                theme = {
                    all = {
                        ui = {
                            fg         = colors.text,
                            fg_dim     = colors.subtext,
                            fg_reverse = colors.base,

                            bg_dim     = colors.surface,
                            bg_gutter  = colors.surface,

                            bg_m3      = colors.surface,
                            bg_m2      = colors.surface,
                            bg_m1      = colors.surface,
                            bg         = colors.base,
                            bg_p1      = colors.highlight,
                            bg_p2      = colors.highlight,

                            special    = colors.subtext,
                            nontext    = colors.overlay,
                            whitespace = colors.overlay,

                            bg_search  = colors.bg_accent_1,
                            bg_visual  = colors.bg_accent_1,

                            pmenu      = {
                                fg       = colors.text,
                                fg_sel   = "none",
                                bg       = colors.highlight,
                                bg_sel   = colors.bg_accent_1,
                                bg_sbar  = colors.surface,
                                bg_thumb = colors.overlay,
                            },
                            float      = {
                                fg        = colors.text,
                                bg        = colors.highlight,
                                fg_border = colors.overlay,
                                bg_border = colors.highlight,
                            },
                        },
                        syn = {
                            string     = colors.fg_green,
                            variable   = "none",
                            number     = colors.fg_red,
                            constant   = colors.fg_yellow,

                            identifier = colors.fg_cyan,
                            parameter  = colors.fg_magenta,
                            fun        = colors.fg_blue,

                            statement  = colors.fg_magenta,
                            keyword    = colors.fg_magenta,
                            operator   = colors.subtext,

                            preproc    = colors.fg_red,
                            type       = colors.fg_cyan,
                            regex      = colors.rg_red,

                            deprecated = colors.overlay,
                            comment    = colors.muted,
                            punct      = colors.muted,

                            special1   = colors.fg_accent_1,
                            special2   = colors.fg_accent_2,
                            special3   = colors.fg_accent_3,
                        },
                        vcs = {
                            added   = colors.fg_green,
                            removed = colors.fg_red,
                            changed = colors.fg_yellow,
                        },
                        diff = {
                            add    = colors.bg_green,
                            delete = colors.bg_red,
                            change = colors.bg_blue,
                            text   = colors.bg_yellow,
                        },
                        diag = {
                            ok      = colors.fg_green,
                            error   = colors.fg_red,
                            warning = colors.fg_yellow,
                            info    = colors.fg_blue,
                            hint    = colors.fg_hint,
                        },
                        term = {
                            colors.black,
                            colors.rg_red,
                            colors.rg_green,
                            colors.rg_yellow,
                            colors.rg_blue,
                            colors.rg_magenta,
                            colors.rg_cyan,
                            colors.white,
                            colors.bright_black,
                            colors.fg_red,
                            colors.fg_green,
                            colors.fg_yellow,
                            colors.fg_blue,
                            colors.fg_magenta,
                            colors.fg_cyan,
                            colors.bright_white,
                        },
                    },
                },
            },
        })
        vim.cmd.colorscheme("kanagawa")
    end

    local signal_handler = function()
        if _G.colorscheme_signal then
            return
        end

        _G.colorscheme_signal = nil

        local uv = vim.uv
        local err = nil
        _G.colorscheme_signal, err = uv.new_signal()
        if _G.colorscheme_signal then
            _G.colorscheme_signal:start("sigusr1", function()
                vim.schedule(set_colorscheme)
            end)
        else
            local msg = string.format("Cannot create new signal!\nError: %s", err)
            vim.notify(msg, vim.log.levels.WARN, { title = "nvim-config" })
        end

        vim.api.nvim_create_autocmd("VimLeavePre", {
            once = true,
            callback = function()
                _G.colorscheme_signal:stop()
                _G.colorscheme_signal:close()
            end,
        })
    end

    set_colorscheme()
    signal_handler()
end
