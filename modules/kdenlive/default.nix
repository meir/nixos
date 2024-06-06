{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.kdenlive.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.kdenlive.enable {
    environment.packages = with pkgs; [ libsForQt5.kdenlive ];
  };
}
