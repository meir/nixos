{ config, pkgs, ... }:
pkgs.mkModule config "docker" {
  virtualisation.docker.enable = true;

  environment.packages = with pkgs; [ docker ];
}
