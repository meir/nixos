{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  startup = concatStringsSep "\n" (map (value: "exec-once = ${value}") config.protocol.autostart);
  rules = concatStringsSep "\n\n" config.protocol.rules;
  binds = pkgs.izuGenerate "hyprland" config.protocol.hotkeys;

  # bind = Super, Return, exec, kitty
  # bind = Super, Space, exec, rofi -show drun
  # bind = Super+Shift, Space, exec, rofi -show run
  # bind = Super, 1, workspace, 1
  # bind = Super, 2, workspace, 2
  # bind = Super, 3, workspace, 3
  # bind = Super, 4, workspace, 4
  # bind = Super, 5, workspace, 5
  # bind = Super, 6, workspace, 6
  # bind = Super, 7, workspace, 7
  # bind = Super, 8, workspace, 8
  # bind = Super, 9, workspace, 9
  # bind = Super, 0, workspace, 10
  # bind = Super+Shift, 1, move, 1
  # bind = Super+Shift, 2, move, 2
  # bind = Super+Shift, 3, move, 3
  # bind = Super+Shift, 4, move, 4
  # bind = Super+Shift, 5, move, 5
  # bind = Super+Shift, 6, move, 6
  # bind = Super+Shift, 7, move, 7
  # bind = Super+Shift, 8, move, 8
  # bind = Super+Shift, 9, move, 9
  # bind = Super+Shift, 0, move, 10

  hyprconfig = pkgs.writeScript "hyprland" (''
    ${readFile binds}
    ${rules}
    ${startup}
    exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once = swww init
    exec-once = mako

    windowrulev2 = opacity 0.0 override, class:^(xwaylandvideobridge)$
    windowrulev2 = noanim, class:^(xwaylandvideobridge)$
    windowrulev2 = noinitialfocus, class:^(xwaylandvideobridge)$
    windowrulev2 = maxsize 1 1, class:^(xwaylandvideobridge)$
    windowrulev2 = noblur, class:^(xwaylandvideobridge)$
    windowrulev2 = nofocus, class:^(xwaylandvideobridge)$
  '');
in
{
  config = mkIf config.protocol.wayland.enable {
    environment.systemPackages = with pkgs; [
      socat
      swww
      waypaper
      kdePackages.xwaylandvideobridge
      wl-clipboard
      mako
    ];

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
