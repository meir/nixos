{
  config,
  options,
  pkgs,
  lib,
  ...
}:
lib.mkModule "docker" {
  virtualisation.docker.enable = true;

  environment.packages = with pkgs; [ docker ];
}
