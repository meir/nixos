{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.gimp.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.gimp.enable { environment.packages = with pkgs; [ gimp ]; };
}
