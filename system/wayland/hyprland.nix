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

  hyprconfig = pkgs.writeScript "hyprland" ''
    ${readFile binds}
    ${rules}
    ${startup}

    env = HYPRCURSOR_THEME,Adwaita
    env = HYPRCURSOR_SIZE,10
    env = XCURSOR_THEME,Adwaita
    env = XCURSOR_SIZE,10

    misc {
      font_family = "DinaRemasterII Nerd Font"
    }

    general {
      col.active_border = rgb(d1496b) rgb(d1496b) 0deg;
      col.inactive_border = rgb(131711) rgb(131711) 0deg;
      border_size = 2 
    } 

    cursor {
      no_warps = true
      enable_hyprcursor = false
    }

    misc {
      disable_hyprland_logo = true
      focus_on_activate = false
    }

    decoration {
      rounding = 10

      active_opacity = 1.0
      inactive_opacity = 0.9

      shadow {
        enabled = false
      }

      blur {
        enabled = true
        size = 10
        passes = 2
        vibrancy = 0.1
      }
    } 

    animations {
      enabled = false
    } 

    dwindle {
      pseudotile = true
    } 

    input {
      follow_mouse = 0
      mouse_refocus = false
      float_switch_override_focus = 0
    } 

    windowrulev2 = opacity 0.0 override, class:^(xwaylandvideobridge)$
    windowrulev2 = noanim, class:^(xwaylandvideobridge)$
    windowrulev2 = noinitialfocus, class:^(xwaylandvideobridge)$
    windowrulev2 = maxsize 1 1, class:^(xwaylandvideobridge)$
    windowrulev2 = noblur, class:^(xwaylandvideobridge)$
    windowrulev2 = nofocus, class:^(xwaylandvideobridge)$
  '';
in
{
  config = mkIf config.protocol.wayland.enable {
    environment.systemPackages = with pkgs; [
      socat
      kdePackages.xwaylandvideobridge
      wl-clipboard
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
