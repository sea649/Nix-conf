{ inputs, ... }: {
  flake.nixosModules.umbriel = { pkgs, lib, config, ... }: {
    imports = [ inputs.umbriel.nixosModules.default ];

    programs.umbriel = {
      enable = true;
      package = pkgs.umbriel;
    };

    environment.systemPackages = with pkgs; [ wlr-randr wlrctl ];

    # The upstream unit already sets ExecStart. Reset it first, otherwise
    # systemd rejects the drop-in with "more than one ExecStart= setting".
    systemd.user.services.umbriel.serviceConfig.ExecStart = lib.mkForce [
      ""
      "${lib.getExe config.programs.umbriel.package} -c ${config.dotfiles.umbrielConfig}"
    ];
  };
}
