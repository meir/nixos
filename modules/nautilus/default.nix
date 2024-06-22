{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.nautilus.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.nautilus.enable {
    environment.packages = with pkgs; [ gnome.nautilus ];
  };
}
