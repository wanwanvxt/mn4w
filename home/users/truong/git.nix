{pkgs, ...}: {
    programs = {
        git = {
            enable = true;
            package = pkgs.gitFull;
            lfs.enable = true;
            settings = {
                init.defaultBranch = "main";
                user = {
                    name = "Vũ Xuân Trường";
                    email = "wanwan.vxt@gmail.com";
                };
            };
        };
        lazygit.enable = true;
    };
}
