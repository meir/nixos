{ config, lib, ... }:

with lib;
{
  config = mkIf (config.protocol.xorg.enable && config.protocol.xorg.wm == "bspwm") {
    services.xserver = {
      displayManager = {
        lightdm = {
          enable = true;
          greeters.gtk = {
            enable = true;
          };
        };
      };
    };
  };
}
