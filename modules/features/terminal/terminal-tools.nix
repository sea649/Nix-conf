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
      bottom
      glow
      yt-dlp
      gh
      zellij
    ];
  };
}
