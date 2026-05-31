{
    home-manager.users.truong = {
        imports = [
            ../../../shared/truong/home/xdg.nix
            ../../../shared/truong/home/bash.nix
            ../../../shared/truong/home/git.nix
            ../../../shared/truong/home/ssh.nix
            ../../../shared/truong/home/neovim
            ../../../shared/truong/home/programs.nix

            # DE/WM
            ../../../shared/truong/home/niri
            ../../../shared/truong/home/pointerCursor.nix
            ../../../shared/truong/home/fonts.nix
            ../../../shared/truong/home/gtk_qt.nix
            ../../../shared/truong/home/ime.nix
            ../../../shared/truong/home/programs_de
            ./niri.nix
        ];
    };
}
