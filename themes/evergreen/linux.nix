{
  options,
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with builtins;
let
  name = "evergreen";
  cfg = config.theme."${name}";
  values = {
    inherit (cfg) font_size dpi;
  };

  rules = {
    xorg = [
      "bspc config normal_border_color '#131711'"
      "bspc config active_border_color '#10A070'"
      "bspc config focused_border_color '#D1496B'"
      "bspc config border_width ${toString (2 * cfg.dpi)}"
    ];

    wayland = [ ];
  };

  xorg = config.protocol.xorg.enable;
  wayland = config.protocol.wayland.enable;
in
{
  options.theme."${name}" = {
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
    protocol.rules = rules."${config.protocol.type}";

    environment.variables = {
      XCURSOR_SIZE = "${toString (32 * cfg.dpi)}";
      GDK_SCALE = "${toString cfg.dpi}";
      GDK_DPI_SCALE = "${toString (1 / cfg.dpi)}";
      _JAVA_OPTIONS = "-Dsun.java2d.uiScale=${toString cfg.dpi}";
    };

    modules = with pkgs; {
      dunst.source = mkIf xorg (
        replace.override {
          src = ./dunst;
          args = values;
        }
      );
      eww.source = replace.override {
        src = ./eww;
        args = values;
      };
      rofi.source = replace.override {
        src = ./rofi;
        args = values;
      };
      kitty.config = replace.override {
        src = ./kitty/kitty.conf;
        args = values;
      };
      qutebrowser = {
        homepage = replace.override {
          src = ./qutebrowser/homepage;
          args = values;
        };
        config = replace.override {
          src = ./qutebrowser/config.py;
          args = values;
        };
      };
    };
  };
}
