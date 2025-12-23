# mn4w - My NixOS for work ❄️

My NixOS configuration (using **Flakes** and **Home Manager**).

---

## 1. Create a new host

Create a new directory under `modules/hosts` using your hostname.

Example:

```nix
# modules/hosts/mypc/default.nix

{ config, pkgs, lib, inputs, ... }: {
    time.timeZone = "Asia/Ho_Chi_Minh";
    i18n.defaultLocale = "en_US.UTF-8";

    imports = [
        ./hardware-configuration.nix
        ./gaming.nix
        # You can also import shared modules here
    ];

    # Host-specific options go here
}
```

A host module is responsible for:

- System-level configuration
- Hardware configuration
- Importing shared system modules

Hosts **do not import users directly**.

## 2. Define users

Users are defined under `modules/users`.
Each user lives in its own module.

You *can* define users directly inside a host configuration,
but this repository avoids that approach to keep user definitions reusable across multiple hosts
and to make user selection explicit at the flake level.

Example:
```text
modules/users/
├── katou/
│   └── default.nix
├── alice/
│   └── default.nix
└── bob/
    └── default.nix
```
```nix
# modules/users/katou/default.nix

{ config, pkgs, lib, inputs, ... }: {
    users.users.katou = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
    };

    # Optional: attach Home Manager configuration
    home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;

        users.katou = {
            programs.kitty.enable = true;
            # Import shared Home Manager modules here if needed
        };
    };

    # You can also import shared modules here
}
```

Each user module may:

- Define exactly one system user
- Optionally attach Home Manager configuration
- Reuse shared Home Manager modules

## 3. Assign users to a host (via `flake.nix`)
```nix
# flake.nix

nixosConfigurations = {
    mypc = mkSystem   "x86_64-linux"   "25.05"          "mypc"      [ "katou" "alice" "bob" ];
                      #system          #state_version   #hostname   #all_users

    # More hosts...
};
```

The user list determines:

- Which user modules are imported
- Which system users and Home Manager configs are enabled on that host

Hosts themselves remain user-agnostic.

## 4. Apply the configuration
```bash
sudo nixos-rebuild switch --flake .#mypc
```
