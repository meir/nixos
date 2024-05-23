{ config, options, pkgs, lib, ... }:
with lib; {
  options.modules.discord.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.discord.enable {
    modules.packages = with pkgs;
      [ (unstable.discord.override { withVencord = true; }) ];

    services.picom.opacityRules = [ "80:class_g = 'discord'" ];
  };
}
