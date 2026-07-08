vim.lsp.config.lua_ls = {
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
                checkThirdParty = false,
                library = {
                    "/etc/profiles/per-user/${env:USER}/share/hypr/stubs"
                },
            },
            diagnostics = { globals = { "hl" } },
            telemetry = { enable = false },
        },
    },
}

vim.lsp.enable({ "lua_ls", "bashls" })
