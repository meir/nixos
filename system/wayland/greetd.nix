{
  options,
  lib,
  config,
  pkgs,
  ...
}:
with lib;
{
  config = mkIf config.protocol.wayland.enable {
    services.displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    services.displayManager.defaultSession = "hyprland-uwsm";
  };
}
