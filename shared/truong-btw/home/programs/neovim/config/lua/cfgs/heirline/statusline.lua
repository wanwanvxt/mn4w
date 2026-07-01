local utils = require("utils")
local hl_utils = require("heirline.utils")
local hl_conds = require("heirline.conditions")
local shared = require("cfgs.heirline.shared")

local ViMode = {
    init = function(self)
        self.mode = vim.fn.mode()
    end,
    static = {
        mode_names = {
            n       = "NOR",
            v       = "VIS",
            V       = "V-LINE",
            ["\22"] = "V-BLK",
            s       = "SEL",
            S       = "S-LINE",
            ["\19"] = "S-BLK",
            i       = "INS",
            R       = "REPL",
            c       = "CMD",
            r       = "HIT",
            ["!"]   = "SH",
            t       = "TERM",
        },
        mode_colors = {
            n       = "green",
            v       = "cyan",
            V       = "cyan",
            ["\22"] = "cyan",
            s       = "purple",
            S       = "purple",
            ["\19"] = "purple",
            i       = "blue",
            R       = "red",
            c       = "orange",
            r       = "orange",
            ["!"]   = "green",
            t       = "green",
        },
    },
    update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function()
            vim.cmd("redrawstatus")
        end),
    },
    provider = function(self)
        return string.format(" %s ", self.mode_names[self.mode])
    end,
    hl = function(self)
        return { bg = self.mode_colors[self.mode], fg = "black", bold = true }
    end,
}

local FileIcon = {
    init = function(self)
        local filetype = vim.bo.filetype
        self.icon, self.icon_hl = require("mini.icons").get("filetype", filetype)
    end,
    condition = function()
        return not vim.g.is_tty
    end,
    provider = function(self)
        return string.format("%s ", self.icon)
    end,
    hl = function(self)
        if hl_conds.is_active() then
            return self.icon_hl
        end
    end,
}

local FilePath = {
    provider = function(self)
        local relpath = vim.fn.fnamemodify(self.filepath, ":.")
        if relpath == "" then return "[No name]" end

        local path = vim.fn.fnamemodify(relpath, ":~:.")
        local head, tail = "", path

        local env_vars = { "VIMRUNTIME" }
        for _, var in ipairs(env_vars) do
            local val = os.getenv(var)
            if val and val ~= "" then
                if path:sub(1, #val) == val then
                    head = "$" .. var
                    tail = path:sub(#val + 1)
                    break
                end
            end
        end

        if not hl_conds.width_percent_below(#head+#tail, 0.4) then
            return head .. vim.fn.pathshorten(tail)
        end

        return head .. tail
    end,
}

local FileFlags = {
    {
        condition = function()
            return vim.bo.modified
        end,
        provider = " [+]",
        hl = function()
            if hl_conds.is_active() then
                return { fg = "yellow" }
            end
        end,
    },
    {
        condition = function()
            return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = " [RO]",
        hl = function()
            if hl_conds.is_active() then
                return { fg = "red" }
            end
        end,
    },
}

local FileEcoding = {
    init = function(self)
        self.enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
        self.fmt = vim.bo.fileformat
        if self.fmt == "dos" then
            self.fmt = "CRLF"
        elseif self.fmt == "unix" then
            self.fmt = "LF"
        elseif self.fmt == "mac" then
            self.fmt = "CR"
        end
    end,
    provider = function(self)
        return string.format("[%s %s]", self.enc, self.fmt)
    end,
    hl = function()
        if hl_conds.is_active() then
            return { fg = "cyan" }
        end
    end,
}

local FileBlock = {
    init = function(self)
        self.filepath = vim.api.nvim_buf_get_name(0) or ""
    end,
    {
        shared.Space,
        FileIcon,
        FilePath,
        FileFlags,
        shared.Space,
        FileEcoding,
        shared.Space,
    },
}

local LSPActive = {
    init = function(self)
        self.servers = {}
        for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
            table.insert(self.servers, server.name)
        end
    end,
    condition = hl_conds.lsp_attached,
    update = { "LspAttach", "LspDetach" },
    hl = { fg = "purple" },
    provider = function(self)
        return string.format("%s%s", utils.symbol_guard(" ", ""), table.concat(self.servers, " "))
    end,
}

local Diagnostics = {
    condition = hl_conds.has_diagnostics,
    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warns  = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.infos  = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
        self.hints  = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    end,
    on_click = {
        name = "StatusLineDiagnosticsOnClick",
        callback = function()
            vim.diagnostic.setqflist()
        end,
    },
    update = { "DiagnosticChanged", "BufEnter" },
    {
        shared.Space,
        {
            provider = function(self)
                return string.format("%s%d", utils.symbol_guard(" ", "E."), self.errors)
            end,
            hl = { fg = "diag_error" },
        },
        shared.Space,
        {
            provider = function(self)
                return string.format("%s%d", utils.symbol_guard(" ", "W."), self.warns)
            end,
            hl = { fg = "diag_warn" },
        },
        shared.Space,
        {
            provider = function(self)
                return string.format("%s%d", utils.symbol_guard(" ", "I."), self.infos+self.hints)
            end,
            hl = { fg = "diag_info" },
        },
        shared.Space,
    },
}

local Location = {
    provider = " %l/%L:%c ",
    hl = { bg = "bright_bg", fg = "green", bold = true },
}

---
local InactiveStatusLine = {
    condition = hl_conds.is_not_active,
    {
        FileBlock,
        shared.Align,
    },
}
local DefaultStatusLine = {
    {
        ViMode,
        FileBlock,
        shared.Align,
        Diagnostics,
        shared.Space,
        LSPActive,
        shared.Space,
        Location,
    },
}

return {
    hl = function()
        return hl_conds.is_active() and "StatusLine" or "StatusLineNC"
    end,
    fallthrough = false,
    InactiveStatusLine,
    DefaultStatusLine,
}
