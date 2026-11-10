{...}: {
  flake.nixosModules.polkit-agent = {pkgs, ...}: {
    environment.systemPackages = [
      (pkgs.writeShellApplication {
        name = "polkit-agent";
        runtimeInputs = [pkgs.polkit_gnome];
        text = "exec ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      })
    ];
    security.polkit = {
      enable = true;
      enablePkexecWrapper = true;
    };
  };
}
