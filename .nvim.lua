local root = vim.fs.root(0, { "flake.nix" })
local hostname = vim.uv.os_gethostname()

local nixpkgs_expr = string.format([[import (builtins.getFlake "%s").inputs.nixpkgs {}]], root)
local nixos_expr   = string.format([[(builtins.getFlake "%s").nixosConfigurations.%s.options]], root, hostname)
local hm_expr      = nixos_expr .. ".home-manager.users.type.getSubOptions []"

vim.lsp.config.nixd = {
    settings = {
        nixd = {
            nixpkgs = {
                expr = nixpkgs_expr,
            },
            options = {
                nixos = {
                    expr = nixos_expr,
                },
                home_manager = {
                    expr = hm_expr,
                },
            },
        },
    },
}

vim.lsp.enable({ "nixd", "bashls" })
