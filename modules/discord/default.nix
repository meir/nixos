{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.discord.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.discord.enable {
    environment.packages = with pkgs; [ (unstable.discord.override { withVencord = true; }) ];

    services.picom.opacityRules = [ "90:class_g = 'discord'" ];
  };
}
