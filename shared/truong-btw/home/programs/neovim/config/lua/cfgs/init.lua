local plugins = {
    "kanagawa", "mini-icons",

    -- lazy load
    "heirline", "virt-column", "which-key", "neo-tree", "fzf",
    "cmp", "lsp", "autoclose", "treesitter", "colorizer",
}

for _, plg in ipairs(plugins) do
    local ok, res = pcall(require, "cfgs." .. plg)
    if not ok then
        local msg = string.format("Config '%s' could not be loaded!\nError: %s", plg, res)
        vim.notify(msg, vim.log.levels.ERROR, { title = "nvim-config" })
    end
end
