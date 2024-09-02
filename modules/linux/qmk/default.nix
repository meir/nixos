{ config, pkgs, ... }:
pkgs.mkModule config "qmk" {
  environment.packages = with pkgs; [
    udev
    vial
    qmk
  ];

  services.udev.packages = with pkgs; [ vial ];
}
