local utils = require("my.utils")
local hl_utils = require("heirline.utils")
local hl_conds = require("heirline.conditions")
local shared = require("plugins.heirline.shared")

local Bufnr = {
    provider = function(self)
        return string.format("%d. ", self.bufnr)
    end,
    hl = "Comment",
}

local FileIcon = {
    init = function(self)
        local filetype = vim.api.nvim_get_option_value("filetype", { buf = self.bufnr })
        self.icon, self.icon_hl = require("mini.icons").get("filetype", filetype)
    end,
    condition = function()
        return not vim.g.is_tty
    end,
    provider = function(self)
        return string.format("%s ", self.icon)
    end,
    hl = function(self)
        return self.icon_hl
    end,
}

local FileName = {
    provider = function(self)
        local filename = vim.fn.fnamemodify(self.filepath, ":t")
        if filename == "" then return "[No name]" end
        return filename
    end,
    hl = function(self)
        if self.is_active then
            return { bold = true }
        end
    end,
}

local FileFlags = {
    {
        condition = function(self)
            return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
        end,
        provider = " [+]",
        hl = function(self)
            if self.is_active then
                return { fg = "yellow" }
            end
        end,
    },
    {
        condition = function(self)
            return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
                or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
        end,
        provider = " [RO]",
        hl = function(self)
            if self.is_active then
                return { fg = "red" }
            end
        end,
    },
}

local FileBlock = {
    init = function(self)
        self.filepath = vim.api.nvim_buf_get_name(self.bufnr)
    end,
    hl = function(self)
        if not self.is_active then
            return { italic = true }
        end
    end,
    {
        FileIcon,
        FileName,
        FileFlags,
    },
}

local BufferBlock = {
    on_click = {
        name = "TablineFileBlockOnClick",
        callback = function(_, minwid, _, button)
            if button == "l" then
                vim.api.nvim_win_set_buf(0, minwid)
            elseif button == "m" then
                vim.api.nvim_buf_delete(minwid, { force = true })
                vim.cmd.redrawtabline()
            end
        end,
        minwid = function(self)
            return self.bufnr
        end,
    },
    hl = function(self)
        return self.is_active and "TabLineSel" or "TabLine"
    end,
    {
        shared.Space,
        Bufnr,
        FileBlock,
        { provider = utils.symbol_guard("▕", " ") },
    },
}

local get_bufs = function()
    return vim.tbl_filter(function(bufnr)
        return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
    end, vim.api.nvim_list_bufs())
end

local buflist_cache = {}

vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
    callback = function(args)
        vim.schedule(function()
            local bufs = get_bufs()
            for i, v in ipairs(bufs) do
                buflist_cache[i] = v
            end
            for i = #bufs+1, #buflist_cache do
                buflist_cache[i] = nil
            end

            if #buflist_cache > 1 then
                vim.o.showtabline = 2
            elseif vim.o.showtabline ~=1 then
                vim.o.showtabline = 1
            end
        end)
    end,
})

local BufferLine = hl_utils.make_buflist(
    BufferBlock,
    { provider = utils.symbol_guard(" ", "< "), hl = { fg = "gray" } },
    { provider = utils.symbol_guard(" ", " >"), hl = { fg = "gray" } },
    function()
        return buflist_cache
    end,
    false
)

local TabBlock = {
    update = { "TabNew", "TabClosed", "TabEnter", "TabLeave", "WinNew", "WinClosed" },
    provider = function(self)
        return string.format(" %d ", self.tabnr)
    end,
    hl = function(self)
        return self.is_active and "TabLineSel" or "TabLine"
    end,
}

local TabPages = {
    condition = function()
        return #vim.api.nvim_list_tabpages() >= 2
    end,
    hl_utils.make_tablist(TabBlock),
}

return {
    BufferLine,
    shared.Align,
    TabPages,
}
