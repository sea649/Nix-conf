{...}: {
  flake.nixosModules.larp-utils = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      cmatrix
      cowsay
      pipes-rs
      onefetch
      cava
      tty-clock
      clock-rs
      lavat
    ];
  };
}
