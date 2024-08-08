{
  options,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.theme.evergreen;
  replace =
    src:
    pkgs.substituteAll {
      inherit src;
      inherit (config.theme.evergreen) font_size dpi;
    };

  replaceAll = src: builtins.map replace src;
in
with lib;
with builtins;
{
  options.theme.evergreen = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };

    font_size = mkOption {
      type = types.int;
      default = 16;
    };

    dpi = mkOption {
      type = types.int;
      default = 1;
    };
  };

  config = {
    bspwm.rules = [
      "bspc config normal_border_color '#131711'"
      "bspc config active_border_color '#10A070'"
      "bspc config focused_border_color '#D1496B'"
      "bspc config border_width ${toString (2 * cfg.dpi)}"
    ];

    environment.variables = {
      XCURSOR_SIZE = "${toString (32 * cfg.dpi)}";
      GDK_SCALE = "${toString cfg.dpi}";
      GDK_DPI_SCALE = "${toString (1 / cfg.dpi)}";
      _JAVA_OPTIONS = "-Dsun.java2d.uiScale=${toString cfg.dpi}";
    };

    modules = {
      dunst.source = ./dunst;
      eww.source = ./eww;
      rofi.source = ./rofi;
      kitty.config = replace ./kitty/kitty.conf;
      qutebrowser = {
        homepage = ./qutebrowser/homepage;
        config = replace ./qutebrowser/config.py;
      };
    };
  };
}
