{ config, options, pkgs, lib, ... }:
with lib; {
  options.modules.polybar.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.polybar.enable {
    modules.packages = with pkgs; [ polybar ];
  };
}
