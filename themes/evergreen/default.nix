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
      dunst.source = mkIf xorg (replace ./dunst values);
      eww.source = replace ./eww values;
      rofi.source = replace ./rofi values;
      kitty.config = replace ./kitty/kitty.conf values;
      qutebrowser = {
        homepage = replace ./qutebrowser/homepage values;
        config = replace ./qutebrowser/config.py values;
      };
    };
  };
}
