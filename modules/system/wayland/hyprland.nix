{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  config = config.protocol.wayland.enable {
    programs.hyprland = {
      xwayland.enable = true;
      enable = true;
    };
  };
}
