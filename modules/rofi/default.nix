{
  lib,
  options,
  config,
  pkgs,
  mkModule,
  ...
}:
with lib;
let
  name = "rofi";
in
recursiveUpdate
  {
    options.modules."${name}".source = mkOption {
      type = types.nullOr types.path;
      default = null;
    };
  }
  (
    mkModule config "${name}" {
      environment.packages = with pkgs; [
        rofi
        clipcat
      ];

      sxhkd.keybind = {
        "super + @space" = "rofi -show drun";
        "shift + super + v" = "clipcat-menu";
      };

      environment.file.rofi = mkIf (config.modules."${name}".source != null) {
        source = config.modules."${name}".source;
        target = ".config/rofi";
      };

      services.clipcat.enable = true;
      environment.file.clipcat = {
        source = ./clipcat;
        target = ".config/clipcat";
      };
    }
  )
