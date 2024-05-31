{ config, options, pkgs, lib, ... }:
with lib; {
  options.modules.rofi.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.rofi.enable {
    environment.packages = with pkgs; [ rofi clipcat ];

    sxhkd.keybind = {
      "super + @space" = "rofi -show drun";
      "shift + super + v" = "clipcat-menu";
    };

    environment.file.rofi = {
      source = ./rofi;
      target = ".config/rofi";
    };

    services.clipcat.enable = true;
    environment.file.clipcat = {
      source = ./clipcatd.toml;
      target = ".config/clipcat/clipcatd.toml";
    };
  };
}
