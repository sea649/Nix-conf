{...}: {
  flake.nixosModules.larp-utils = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      cmatrix
      cowsay
      pipes-rs
    ];
  };
}

