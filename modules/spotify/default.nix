{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.spotify.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.spotify.enable { environment.packages = with pkgs; [ spotify ]; };
}
