{
  options,
  lib,
  config,
  pkgs,
  ...
}:
with lib builtins;
let
  rules = {
    wayland = readFile ./config/hypr/hyprland.conf;
    xorg = readFile ./config/bspwm/config;
  };
in
{
  options.theme.evergreen.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf config.theme.evergreen.enable {
    protocol.rules = rules."${config.protocol.type}";

    hm.home.file = {
      ".config/starship.toml".source = ./config/zsh/starship.toml;
      ".config/kitty/kitty.conf".source = ./config/kitty/kitty.conf;

      ".config/qutebrowser/config.py".source = ./config/qutebrowser/config.py;
      ".config/qutebrowser/userscripts".source = ./config/qutebrowser/userscripts;

      ".config/wlxoverlay/keyboard.yaml".source = ./config/wlxoverlay/keyboard.yaml;
      ".config/wlxoverlay/watch.yaml".source = ./config/wlxoverlay/watch.yaml;

      ".config/eww".source = ./config/eww;

      ".config/mpv/mpv.conf".source = ./config/mpv/mpv.conf;

      ".config/rofi".source = .config/rofi;
    };
  };
}
