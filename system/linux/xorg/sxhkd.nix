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
in
{
  config = mkIf config.protocol.xorg.enable {
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

    hm.home.file.".config/sxhkd/sxhkdrc" = {
      source = buildHkdrc;
    };
  };
}
