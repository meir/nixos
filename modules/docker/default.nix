{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
mkModule "docker" {
  virtualisation.docker.enable = true;

  environment.packages = with pkgs; [ docker ];
}
