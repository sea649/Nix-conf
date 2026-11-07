# Sea's dotfiles
## Install

Fresh machine, nothing set up yet:

1.  Bootstrap: get a temporary git + SSH key, register the key with GitHub
```
nix-shell -p git --run "
    mkdir -p ~/.ssh &&
    ssh-keygen -t ed25519 -C 'sea' -f ~/.ssh/id_ed25519 -N '' &&
    cat ~/.ssh/id_ed25519.pub
    "
```

copy the printed key to <https://github.com/settings/ssh/new>

1.  Clone
```
nix-shell -p git --run "
	cd ~ &&
    git clone git@github.com:sea649/Nix-conf.git
    "
```

1.  Regenerate hardware config, edit settings, build
```
sudo nixos-generate-config --show-hardware-config > ~/Nix-conf/hosts/steamdeck/hardware-configuration.nix
## -> edit ~/Nix-conf/hosts/steamdeck/settings.nix (kernel, jovian, themes)
sudo nixos-rebuild switch --flake ~/Nix-conf#steamdeck
## #<name> must match the hosts/<name> directory name
```

1.  Reboot
```
sudo reboot
```

After the first switch, **\`nh\` (Nix Helper)** is installed, so day-to-day use:
```
nh os switch ~/Nix-conf
```

\#### Changing hardware

Hardware-specific settings are variables in `hosts/steamdeck/settings.nix` (validated by `modules/options.nix`):
```
## options: normal, zen, steamdeck
kernel = "steamdeck";
## Steam Deck / Jovian support (false on non-Deck hardware)
jovian = true;
```

****Moving to a VM:****

-   Create a new host directory (e.g. `hosts/nixvm`) with `jovian = false` — the Jovian module and Steam Deck profile are skipped.
-   Add `WLR_RENDERER_ALLOW_SOFTWARE = "1";` to `environment.sessionVariables` (VMs lack real GPU acceleration).
-   Set `desktop = false` in that host's `settings.nix` to skip the compositor, greeter and GUI home modules.

****Moving to different hardware:****

-   Create a new `hosts/<host>/` directory; the flake auto-discovers it (remember to `git add`).
-   Set `kernel = "normal"` (nixpkgs latest) or `kernel = "zen"` (desktop/gaming optimised).
-   **GPU driver**:
    -   **AMD / Intel**: nothing to change — `amdgpu/i915` ship in the kernel and `hardware.graphics` enables Mesa.
    -   **Nvidia**: add the proprietary driver alongside `hardware.graphics` (which stays — Nvidia still needs Mesa for OpenGL/Vulkan):
```
services.xserver.videoDrivers = [ "nvidia" ];
hardware.nvidia = {
    modesetting.enable = true;  ## required for Wayland
    open = true;                ## open kernel modules (RTX 2000+); false otherwise
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
```
-   Always regenerate `hardware-configuration.nix` on the new machine:
    `sudo nixos-generate-config --show-hardware-config > hosts/<host>/hardware-configuration.nix`

\#### Configuration
```
- ****Host values****: `hosts/steamdeck/settings.nix` (typed by `modules/options.nix`).
- ****Umbriel****: `hosts/<host>/umbriel.conf` (raw TOML, per host).
- ****Noctalia****: `hosts/<host>/noctalia.toml` (per host; edit via the Settings UI, then run `noctalia-update`).
- ****Secrets****: agenix — see `important.txt`.
```
## Structure
```
    flake.nix                 flake at the repo root
    hosts/<host>/             per machine: configuration.nix, hardware-configuration.nix, settings.nix
                              (auto-discovered as nixosConfigurations.<dirname>)
    modules/options.nix       typed dotfiles.* options (enums + descriptions)
    modules/nixos/            split system modules (boot, audio, networking, greeter, ...)
    modules/cursor/           palette-driven Bibata cursor generator + greeter fallback
    home/                     home-manager config (entrypoint: home/home.nix; GUI stack: home/graphical.nix)
    configs/ assets/ scripts/ raw configs, assets, user scripts
    secrets/                  agenix recipients (encrypted .age files)
    important.txt             follow-ups (mic test, agenix setup, cursor test)
```
## Install

Fresh machine, nothing set up yet:

1.  Bootstrap: get a temporary git + SSH key, register the key with GitHub
```
    nix-shell -p git --run "
      mkdir -p ~/.ssh &&
      ssh-keygen -t ed25519 -C 'sea' -f ~/.ssh/id_ed25519 -N '' &&
      cat ~/.ssh/id_ed25519.pub
    "
```

copy the printed key to <https://github.com/settings/ssh/new>

1.  Clone
```
    nix-shell -p git --run "
      cd ~ &&
      git clone git@github.com:sea649/Nix-conf.git
    "
```

1.  Regenerate hardware config, edit settings, build
```
    sudo nixos-generate-config --show-hardware-config > ~/Nix-conf/hosts/steamdeck/hardware-configuration.nix
    ## -> edit ~/Nix-conf/hosts/steamdeck/settings.nix (kernel, jovian, themes)
    sudo nixos-rebuild switch --flake ~/Nix-conf#steamdeck   ## #<name> must match the hosts/<name> directory name
```

1.  Reboot
```
    sudo reboot
```

After the first switch, **\`nh\` (Nix Helper)** is installed, so day-to-day use:
```
   nh os switch ~/Nix-conf
```

\#### Changing hardware

Hardware-specific settings are variables in `hosts/steamdeck/settings.nix` (validated by `modules/options.nix`):
```
   ## options: normal, zen, steamdeck
   kernel = "steamdeck";
   ## Steam Deck / Jovian support (false on non-Deck hardware)
   jovian = true;
```

**Moving to a VM:**

-   Create a new host directory (e.g. `hosts/nixvm`) with `jovian = false` — the Jovian module and Steam Deck profile are skipped.
-   Add `WLR_RENDERER_ALLOW_SOFTWARE = "1";` to `environment.sessionVariables` (VMs lack real GPU acceleration).
-   Set `desktop = false` in that host's `settings.nix` to skip the compositor, greeter and GUI home modules.

**Moving to different hardware:**

-   Create a new `hosts/<host>/` directory; the flake auto-discovers it (remember to `git add`).
-   Set `kernel = "normal"` (nixpkgs latest) or `kernel = "zen"` (desktop/gaming optimised).
-   **GPU driver**:
    -   **AMD / Intel**: nothing to change — `amdgpu/i915` ship in the kernel and `hardware.graphics` enables Mesa.
    -   **Nvidia**: add the proprietary driver alongside `hardware.graphics` (which stays — Nvidia still needs Mesa for OpenGL/Vulkan):
```
            services.xserver.videoDrivers = [ "nvidia" ];
            hardware.nvidia = {
              modesetting.enable = true;  ## required for Wayland
              open = true;                ## open kernel modules (RTX 2000+); false otherwise
              package = config.boot.kernelPackages.nvidiaPackages.stable;
            };
```
-   Always regenerate `hardware-configuration.nix` on the new machine:
    `sudo nixos-generate-config --show-hardware-config > hosts/<host>/hardware-configuration.nix`
