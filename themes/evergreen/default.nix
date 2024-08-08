{
  options,
  lib,
  config,
  pkgs,
  ...
}:
let
  replace =
    src:
    pkgs.substituteAll {
      inherit src;
      inherit (options.theme.evergreen) font_size dpi;
    };

  replaceAll = src: builtins.map replace src;
in
with lib;
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
      "bspc config border_width 2"
    ];

    modules = {
      dunst.source = ./dunst;
      eww.source = ./eww;
      rofi.source = ./rofi;
      qutebrowser = {
        homepage = replaceAll ./qutebrowser/homepage/;
        config = replace ./qutebrowser/config.py;
      };
    };
  };
}
