{ config, options, pkgs, lib, ... }:
with lib;
{ 
  options.modules.discord.enable = mkOption {
    type = types.bool;
    default = false;
  };

  config = mkIf config.modules.discord.enable {
    modules.packages = with pkgs; [
    ];
  };
}
