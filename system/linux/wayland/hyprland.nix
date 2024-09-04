{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  hyprconfig = pkgs.writeScript "hyprland" (''
    bind = SUPER, RETURN, exec, kitty
  '');
in
{
  config = mkIf config.protocol.wayland.enable {
    programs.hyprland = {
      xwayland.enable = true;
      enable = true;
    };

    hm.home.file.".config/hypr/hyprland.conf" = {
      source = hyprconfig;
    };
  };
}
