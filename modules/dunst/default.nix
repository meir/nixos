{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.dunst.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.dunst.enable {
    environment.packages = with pkgs; [ dunst ];
  };
}
