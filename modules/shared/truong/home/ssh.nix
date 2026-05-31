{
    programs.ssh = {
        enable = true;
        enableDefaultConfig = false;

        settings = {
            "*" = {
                ForwardAgent = false;
                AddKeysToAgent = "yes";
                Compression = false;
                ServerAliveInterval = 0;
                ServerAliveCountMax = 3;
                HashKnownHosts = false;
                UserKnownHostsFile = "~/.ssh/known_hosts";
                ControlMaster = "no";
                ControlPath = "~/.ssh/master-%r@%n:%p";
                ControlPersist = "no";
            };

            "github.com codeberg.org" = {
                IdentityFile = "~/.ssh/git";
                User = "git";
            };

            "aur.archlinux.org" = {
                IdentityFile = "~/.ssh/aur";
                User = "aur";
                AddressFamily = "inet";
            };
        };
    };

    services.ssh-agent.enable = true;
}
