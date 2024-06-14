{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.docker.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.docker.enable {

    virtualisation.docker.enable = true;

    environment.packages = with pkgs; [ docker ];
  };
}
