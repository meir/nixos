{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  config = mkIf (config.protocol.xorg.enable && config.protocol.xorg.wm == "gnome") {
    services.xserver = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
