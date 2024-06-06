{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.stremio.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.stremio.enable { environment.packages = with pkgs; [ stremio ]; };
}
