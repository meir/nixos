{
  config,
  options,
  pkgs,
  lib,
  ...
}:

with lib;
{
  config = mkIf config.protocol.wayland.enable { services.xserver.displayManager.gdm.enable = true; };
}
