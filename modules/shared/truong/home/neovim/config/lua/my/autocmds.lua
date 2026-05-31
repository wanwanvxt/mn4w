local utils = require("my.utils")

-- display message when current file is not in utf-8 format
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    group = vim.api.nvim_create_augroup("non_utf8_file", { clear = true }),
    callback = function()
        if vim.bo.fileencoding ~= "utf-8" then
            vim.notify("File not in UTF-8 format!", vim.log.levels.WARN, { title = "nvim-config" })
        end
    end,
})

-- highlight yanked region
vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
    callback = function()
        vim.hl.on_yank { higroup = "YankColor", timeout = 300 }
    end,
})

-- auto create directory when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
    callback = function(ctx)
        local dir = vim.fn.fnamemodify(ctx.file, ":p:h")
        utils.mkdir(dir)
    end,
})

-- trailing whitespace when saving
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    group = vim.api.nvim_create_augroup("auto_trailing", { clear = true }),
    callback = function()
        local save = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save)
    end,
})

-- resize all windows when resize terminal
vim.api.nvim_create_autocmd("VimResized", {
    group = vim.api.nvim_create_augroup("win_autoresize", { clear = true }),
    command = "wincmd =",
})

-- large file
vim.api.nvim_create_autocmd("BufReadPre", {
    group = vim.api.nvim_create_augroup("large_file", { clear = true }),
    callback = function(ev)
        local size = vim.fn.getfsize(ev.file)
        if size > 1024*1024 then
            vim.bo.swapfile = false
            vim.bo.undolevels = -1
            vim.wo.relativenumber = false
            vim.wo.number = false
        end
    end,
})
