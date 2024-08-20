{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
let
  buildHkdrc = pkgs.writeScript "hkdrc" (
    concatStringsSep "\n" (
      mapAttrsToList (name: value: ''
        ${name}
          ${value}
      '') config.protocol.hotkeys
    )
  );

  settings = {
    xorg = {
      services.xserver.windowManager.bspwm.sxhkd.configFile = buildHkdrc;

      environment.defaultPackages = with pkgs; [ sxhkd ];

      protocol = {
        hotkeys = {
          "shift + super + r" = ''
            pkill -x sxhkd && sxhkd &
          '';
        };

        autostart = [ "sxhkd &" ];
      };

      environment.file.sxhkd = {
        source = buildHkdrc;
        target = ".config/sxhkd/sxhkdrc";
      };
    };

    wayland = {
      environment.defaultPackages = with pkgs; [ swhkd ];

      protocol = {
        hotkeys = {
          "shift + super + r" = ''
            pkill -HUP swhkd
          '';
        };

        autoastart = [
          "swhks &"
          "pkexec swhkd &"
        ];
      };

      environment.file.swhkd = {
        source = buildHkdrc;
        target = ".config/swhkd/swhkdrc";
      };
    };
  };
in
{
  config = settings.xorg;
}
