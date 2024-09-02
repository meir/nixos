{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  rules = {
    xorg = [ "bspc rule -a Nsxiv state=floating" ];
    wayland = [ ];
  };
in
pkgs.mkModule config "walld" {
  environment.packages = with pkgs; [
    (nsxiv.override { conf = lib.readFile ./nsxiv.conf.h; })
    walld
  ];

  protocol.rules = rules."${config.protocol.type}";
  protocol.hotkeys = {
    "super + w" = "wall-d -R -f -d ~/Pictures/backgrounds";
  };
}
