local utils = require("my.utils")

utils.lazy({
    name = "neo-tree",
    packs = {
        { src = utils.gh("nvim-neo-tree/neo-tree.nvim"), version = "v3.x" },
        -- dependencies
        utils.gh("nvim-lua/plenary.nvim"),
        utils.gh("MunifTanjim/nui.nvim"),
    },
    cmd = "Neotree",
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            popup_border_style = vim.o.winborder,
            enable_git_status = true,
            enable_diagnostics = true,
            sort_case_insensitive = true,
            renderers = {
                directory = {
                    { "indent" },
                    { "current_filter" },
                    { "icon" },
                    { "name" },
                },
                file = {
                    { "indent" },
                    { "icon" },
                    { "name" },
                    { "modified" },
                    { "clipboard" },
                    {
                        "container",
                        content = {
                            { "symlink_target", zindex = 10, align = "right" },
                        },
                    },
                },
            },
            default_component_configs = {
                indent = {
                    enabled = true,
                    indent_size = 2,
                    padding = 0,
                    with_markers = true,
                    indent_marker = "│",
                    last_indent_marker = "└",
                    highlight = "NonText",
                    with_expanders = false,
                },
                current_filter = { enabled = true },
                icon = {
                    enabled = true,
                    highlight = "NonText",
                    use_filtered_colors = true,
                    folder_open = utils.symbol_guard("", "[-]"),
                    folder_closed = utils.symbol_guard("", "[+]"),
                    folder_empty = utils.symbol_guard("", "[+]"),
                    folder_empty_open = utils.symbol_guard("", "[+]"),
                    default = "*",
                },
                name = {
                    enabled = true,
                    use_git_status_colors = true,
                    use_filtered_colors = true,
                    highlight_opened_files = true,
                    highlight = "Normal",
                },
                clipboard = {
                    enabled = true,
                    highlight = "NonText",
                },
                modified = {
                    enabled = true,
                    symbol = "[+]",
                    highlight = "Constant",
                },
                symlink_target = {
                    enabled = true,
                    highlight = "NonText",
                },
            },
            window = { position = "float" },
            filesystem = {
                hijack_netrw_behavior = "open_current",
                use_libuv_file_watcher = true,
                filtered_items = {
                    visible = false,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_ignored = true,
                    hide_by_name = { ".git", "node_modules", ".yolk_git", ".deployed_cache" },
                },
                follow_current_file = { enabled = true },
            },
            buffers = {
                follow_current_file = { enabled = true },
            },
        })
    end,
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { silent = true, desc = "toggle neo-tree" })
