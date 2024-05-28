{ config, options, pkgs, lib, ... }:
with lib; {
  options.modules.rofi.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.rofi.enable {
    modules.packages = with pkgs; [ rofi clipcat ];
    environment.file.rofi = {
      source = ./config.rasi;
      target = ".config/rofi/config.rasi";
    };

    services.clipcat.enable = true;
    environment.file.clipcat = {
      source = ./clipcatd.toml;
      target = ".config/clipcat/clipcatd.toml";
    };
  };
}
