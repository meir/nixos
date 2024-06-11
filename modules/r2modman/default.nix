{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.r2modman.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.r2modman.enable { environment.packages = with pkgs; [ r2modman ]; };
}
