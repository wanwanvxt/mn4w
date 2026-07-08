local utils = require("utils")

utils.lazy({
    name = "lsp",
    packs = {
        utils.gh("neovim/nvim-lspconfig"),
        -- dependencies
        utils.gh("hrsh7th/cmp-nvim-lsp"),
    },
    event = "BufReadPre",
    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

        vim.lsp.config("*", {
            capabilities = capabilities,
        })

        vim.diagnostic.config({
            float = { border = vim.o.winborder },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "E",
                    [vim.diagnostic.severity.WARN]  = "W",
                    [vim.diagnostic.severity.INFO]  = "I",
                    [vim.diagnostic.severity.HINT]  = "I",
                },
            },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(event)
                local bufnr = event.buf
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, buffer = bufnr, desc = "goto definition" })
                vim.keymap.set("n", "gr", vim.lsp.buf.references, { silent = true, buffer = bufnr, desc = "goto references" })
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = vim.o.winborder}) end, { silent = true, buffer = bufnr, desc = "hover documentation" })
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,      { silent = true, buffer = bufnr, desc = "rename symbol" })
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { silent = true, buffer = bufnr, desc = "choose code action" })
            end
        })
    end,
})
