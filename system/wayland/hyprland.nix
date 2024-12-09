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
    bind = SUPER, SPACE, exec, rofi -show drun
    bind = SUPER, SHIFT, Space, exec, rofi -show run
    bind = SUPER, KP_1, workspace, 1
    bind = SUPER, KP_2, workspace, 2
    bind = SUPER, KP_3, workspace, 3
    bind = SUPER, KP_4, workspace, 4
    bind = SUPER, KP_5, workspace, 5
    bind = SUPER, KP_6, workspace, 6
    bind = SUPER, KP_7, workspace, 7
    bind = SUPER, KP_8, workspace, 8
    bind = SUPER, KP_9, workspace, 9
    bind = SUPER, KP_0, workspace, 10
    bind = SUPER, SHIFT, KP_1, move, 1
    bind = SUPER, SHIFT, KP_2, move, 2
    bind = SUPER, SHIFT, KP_3, move, 3
    bind = SUPER, SHIFT, KP_4, move, 4
    bind = SUPER, SHIFT, KP_5, move, 5
    bind = SUPER, SHIFT, KP_6, move, 6
    bind = SUPER, SHIFT, KP_7, move, 7
    bind = SUPER, SHIFT, KP_8, move, 8
    bind = SUPER, SHIFT, KP_9, move, 9
    bind = SUPER, SHIFT, KP_0, move, 10
  '');
in
{
  config = mkIf config.protocol.wayland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };

    hm.home.file.".config/hypr/hyprland.conf" = {
      source = hyprconfig;
    };
  };
}
