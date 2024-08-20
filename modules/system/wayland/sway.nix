{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  buildSway = pkgs.writeScript "init" (concatStringsSep "\n" config.protocol.rules);
in
{
  environment.defaultPackages = with pkgs; [ xorg.xf86videonouveau ];

  programs.sway = {
    enable = true;

    xwayland.enable = true;
  };

  environment.file.sway = {
    source = buildSway;
    target = ".config/sway/config";
  };

  protocol = {
    rules = [ "set $mod Mod4" ];
    hotkeys = {
      "super + q" = ''
        swaymsg kill
      '';

      "super + {_, shift + }{1-9,0}" = ''
        swaymsg {workspace number, move container to workspace number} {1-9,10}
      '';

      "super + {h, j, k, l}" = ''
        swaymsg focus {left, down, up, right}
      '';

      "super + {t, shift + t}" = ''
        swaymsg floating toggle
      '';
    };
  };
}
