{ config, pkgs, ... }:
pkgs.mkModule config "droidcam" {
  security.polkit.enable = true;
  boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

  programs.droidcam.enable = true;
}
