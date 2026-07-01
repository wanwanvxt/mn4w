{ pkgs, config, lib, ... }: {
    config = lib.mkIf config.truong-btw.enable {
        home.packages = with pkgs; [
            trash-cli
            jq
        ];
    };

    imports = [
        ./bash.nix
        ./git.nix
        ./ssh.nix
        ./neovim
    ];
}
