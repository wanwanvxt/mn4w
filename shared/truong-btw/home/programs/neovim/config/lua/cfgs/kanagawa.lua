if not vim.g.is_tty then
    local utils = require("utils")
    vim.pack.add({ utils.gh("rebelot/kanagawa.nvim") })

    -- config
    local update_colorscheme = function()
        local ok = pcall(vim.cmd.colorscheme, "chameleon")
        if not ok then
            vim.cmd.colorscheme("kanagawa")
        end
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

    update_colorscheme()
    signal_handler()
end
