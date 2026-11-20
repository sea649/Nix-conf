{...}: {
  flake.nixosModules.terminal-tools = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      fd
      ripgrep
      jq
      eza
      bat
      zoxide
      fzf
      cliphist
      wl-clipboard
      microfetch
      glow
      yt-dlp
      gh
      zellij
    ];
  };
}
