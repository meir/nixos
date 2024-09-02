{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.modules.docker.enable = mkEnableOption "docker";

  config = mkIf config.modules.docker.enable {
    virtualisation.docker.enable = true;

    environment.packages = with pkgs; [ docker ];
  };
}