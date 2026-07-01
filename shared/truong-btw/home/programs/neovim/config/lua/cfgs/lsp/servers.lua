return {
    nixd     = { cmd = { "nixd" } },
    vimls    = { cmd = { "vim-language-server", "--stdio" } },
    lua_ls   = { cmd = { "lua-language-server" } },
    bashls   = { cmd = { "bash-language-server", "start" } },
    fish_lsp = { cmd = { "fish-lsp", "start" } },
    pylsp    = { cmd = { "pylsp" } },
    ruff     = { cmd = { "ruff", "server" } },
    clangd   = { cmd = { "clangd" } },
    qmlls    = { cmd = { "qmlls6" } },
    ols      = { cmd = { "ols" } },
}
