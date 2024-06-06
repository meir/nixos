{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.lmms.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.lmms.enable { environment.packages = with pkgs; [ lmms ]; };
}
