{...}: {
  flake.nixosModules.fonts = {pkgs, ...}: {
    fonts = {
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        maple-mono.NF
        noto-fonts-color-emoji
      ];
      fontconfig.defaultFonts = {
        sansSerif = ["Maple Mono NF"];
        serif = ["Maple Mono NF"];
        monospace = ["Maple Mono NF"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
