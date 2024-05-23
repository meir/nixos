{ config, options, pkgs, lib, ... }:
with lib; {
  options.modules.rofi.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config =
    mkIf config.modules.rofi.enable { modules.packages = with pkgs; [ rofi ]; };
}
