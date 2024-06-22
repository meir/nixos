{
  config,
  options,
  pkgs,
  lib,
  ...
}:
let
  vencord = false;
in
with lib;
{
  options.modules.discord.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.discord.enable {
    environment.packages = with pkgs; [ (unstable.discord.override { withVencord = vencord; }) ];

    services.picom.opacityRules = [ "90:class_g = 'discord'" ];
  };
}
