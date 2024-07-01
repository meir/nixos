{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.premid.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.premid.enable { environment.packages = with pkgs; [ premid ]; };
}
