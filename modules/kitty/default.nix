{ config, options, pkgs, lib, ... }:
with lib;
{
  options.modules.kitty.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf config.modules.kitty.enable {
    modules.packages = with pkgs; [
      kitty
    ];
  };
}
