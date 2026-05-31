local utils = require("my.utils")

utils.lazy({
    name = "cmp",
    packs = {
        utils.gh("hrsh7th/nvim-cmp"),
        -- dependencies
        utils.gh("hrsh7th/vim-vsnip"),
        utils.gh("hrsh7th/vim-vsnip-integ"),
        utils.gh("hrsh7th/cmp-path"),
        utils.gh("hrsh7th/cmp-buffer"),
        utils.gh("hrsh7th/cmp-cmdline"),
        utils.gh("hrsh7th/cmp-nvim-lsp"),
    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
        local cmp = require("cmp")
        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body)
                end,
            },
            window = {
              completion = cmp.config.window.bordered(),
              documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif vim.fn["vsnip#jumpable"](1) == 1 then
                        vim.fn.feedkeys(vim.api.nvim_replace_termcodes(
                            "<Plug>(vsnip-jump-next)", true, true, true
                        ), "")
                    else
                        fallback()
                    end
                end),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                        vim.fn.feedkeys(vim.api.nvim_replace_termcodes(
                            "<Plug>(vsnip-jump-prev)", true, true, true
                        ), "")
                    else
                        fallback()
                    end
                end),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<Esc>"] = cmp.mapping.close(),
            }),
            sources = {
                { name = "vsnip" },
                { name = "path" },
                { name = "buffer" },
                { name = "nvim_lsp" },
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "path" },
                { name = "cmdline" },
            },
        })
        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            }
        })
    end,
})

