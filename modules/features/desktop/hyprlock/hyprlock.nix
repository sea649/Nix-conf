{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.hyprlock = moduleWithSystem ({self', ...}: {
    environment.systemPackages = with self'.packages; [
      hyprlock
    ];
    security.pam.services.hyprlock = {};
  });
  perSystem = {pkgs, ...}: {
    packages.hyprlock = inputs.wrappers.wrappers.hyprlock.wrap {
      inherit pkgs;
      "hyprlock.conf".content = ''
        source = ${./mocha.conf}

        $accent = $mauve
        $accentAlpha = $mauveAlpha
        $font = Maple Mono NF ExtraBold

        # GENERAL
        general {
          hide_cursor = true
        }

        # BACKGROUND
        background {
          monitor =
          path = screenshot
          blur_passes = 3
          color = rgba(0, 0, 0, 0)
        }

        # TIME
        label {
          monitor =
          text = $TIME
          color = $text
          font_size = 90
          font_family = $font
          position = -30, 0
          halign = right
          valign = top
        }

        # DATE
        label {
          monitor =
          text = cmd[update:43200000] date +"%A, %d %B %Y"
          color = $text
          font_size = 25
          font_family = $font
          position = -30, -150
          halign = right
          valign = top
        }

        image {
          path = ${./cat.png}
          size = 240
          border_color = transparent
          rounding = 0
          position = 0, 7px
        }

        # USER AVATAR
        image {
          monitor =
          path = $HOME/Nix-conf/assets/noctalia/avatar/avatar.png
          size = 100
          border_color = $accent
          position = 0, 75
          halign = center
          valign = center
        }

        # INPUT FIELD
        input-field {
          monitor =
          size = 300, 60
          outline_thickness = 4
          dots_size = 0.2
          dots_spacing = 0.2
          dots_center = true
          outer_color = $accent
          inner_color = $surface0
          font_color = $text
          fade_on_empty = false
          placeholder_text = <span foreground="##$textAlpha"><i>󰌾 Logged in as </i><span foreground="##$accentAlpha">$USER</span></span>
          hide_input = false
          check_color = $accent
          fail_color = $red
          fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i>
          capslock_color = $yellow
          position = 0, -47
          halign = center
          valign = center
        }


      '';
    };
  };
}
