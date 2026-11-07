{ ... }: {
  flake.nixosModules.keepassxc = { config, pkgs, ... }: {
    environment.systemPackages = [ pkgs.keepassxc ];

    hjem.users.${config.dotfiles.username}.files = {
      ".config/net.imput.helium/NativeMessagingHosts/org.keepassxc.keepassxc_browser.json".text =
        builtins.toJSON
          {
            name = "org.keepassxc.keepassxc_browser";
            description = "KeePassXC integration with native messaging support";
            path = "${pkgs.keepassxc}/bin/keepassxc-proxy";
            type = "stdio";
            allowed_origins = [
              "chrome-extension://oboonakemofpalcgghocfoadofidjkkk/"
              "chrome-extension://pdffhmdngciaglkoonimfcmckehcpafo/"
            ];
          };

      ".librewolf/native-messaging-hosts/org.keepassxc.keepassxc_browser.json".text = builtins.toJSON {
        name = "org.keepassxc.keepassxc_browser";
        description = "KeePassXC integration with native messaging support";
        path = "${pkgs.keepassxc}/bin/keepassxc-proxy";
        type = "stdio";
        allowed_extensions = [ "keepassxc-browser@keepassxc.org" ];
      };
    };
  };
}
