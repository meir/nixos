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

    environment.file.hyprland = {
      source = hyprconfig;
      target = ".config/hypr/hyprland.conf";
    };
  };
}
