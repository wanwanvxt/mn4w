local utils = require("my.utils")

-------------------
--### GLOBALS ###--
-------------------
-- leader key
vim.g.mapleader = " "

-- language
vim.cmd([[language en_US.UTF-8]])

-- disable language providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

-- disable builtin plugins not used
local disabled_builtins = {
    "tutor_mode_plugin", "2html_plugin", "netrw", "netrwPlugin", "fzf",
    "zipPlugin", "gzip", "tarPlugin", "matchit", "matchparen", "sql_completion"
}
for _, plugin in ipairs(disabled_builtins) do
    vim.g["loaded_" .. plugin] = 1
end

-- custom global variables
vim.g.is_tty = utils.is_tty()

-------------------
--### OPTIONS ###--
-------------------
vim.opt.swapfile    = false -- disable swapfiles
vim.opt.autoread    = true  -- reload file if changed outside
vim.opt.confirm     = true  -- ask for confirmation
vim.opt.updatetime  = 500   -- CursorHold events
vim.opt.timeoutlen  = 500   -- mapped key timeout

-- clipboard
if vim.fn["provider#clipboard#Executable"]() ~= "" then
    vim.opt.clipboard:append("unnamedplus")
end

vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.cursorline     = true
vim.opt.showmode       = false
vim.opt.ruler          = false
vim.opt.colorcolumn    = "80,110"
vim.opt.showcmdloc     = "statusline"
vim.opt.scrolloff      = 3
local blink = "-blinkwait700-blinkoff400-blinkon250"
vim.opt.guicursor = {
    "n-v-c:block-Cursor/lCursor" .. blink,
    "i-ci-ve:ver25-Cursor2/lCursor2" .. blink,
    "r-cr:hor20" .. blink,
    "o:hor20",
}

-- non-printable characters
vim.opt.list = true
vim.opt.listchars = {
    tab      = utils.symbol_guard("⇥ ", "> "),
    extends  = utils.symbol_guard("»", ">"),
    precedes = utils.symbol_guard("«", "<"),
    nbsp     = utils.symbol_guard("␣", "~"),
    trail    = utils.symbol_guard("·", "."),
}

-- tab & indent
vim.opt.tabstop     = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth  = 4
vim.opt.expandtab   = true
vim.opt.smartindent = true

-- case-sensitive search
vim.opt.ignorecase = true
vim.opt.smartcase  = true

-- window
vim.opt.splitbelow  = true
vim.opt.splitright  = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.o.winborder     = "rounded"

-- mouse
vim.opt.mouse       = "a"
vim.opt.mousemodel  = "extend"
vim.opt.mousescroll = { "ver:3", "hor:0" }
