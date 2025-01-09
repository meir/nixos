{
  nixpkgs-unstable,
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
