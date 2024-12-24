{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  buildBspwm = pkgs.writeScript "bspwmrc" (
    concatStringsSep "\n\n" ([ "#!/bin/sh" ] ++ config.protocol.rules ++ config.protocol.autostart)
  );
in
{
  config = mkIf (config.protocol.xorg.enable && config.protocol.xorg.wm == "bspwm") {
    services.xserver.windowManager.bspwm = {
      enable = true;
      configFile = buildBspwm;
    };

    services.displayManager.defaultSession = "none+bspwm";
  };
}
