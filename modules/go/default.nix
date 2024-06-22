{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.go.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.go.enable { environment.packages = with pkgs; [ go ]; };
}
