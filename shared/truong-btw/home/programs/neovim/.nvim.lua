vim.lsp.config.lua_ls = {
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
                checkThirdParty = false,
                library = {
                    "$VIMRUNTIME/lua",
                    "$XDG_DATA_HOME/nvim/site/pack/core/opt",
                },
            },
            diagnostics = { globals = { "vim" } },
            telemetry = { enable = false },
        },
    },
}

vim.lsp.enable({ "lua_ls" })
