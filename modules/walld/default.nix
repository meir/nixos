{
  config,
  pkgs,
  mkModule,
  lib,
  ...
}:
with lib;
let
  rules = {
    xorg = [ "bspc rule -a Nsxiv state=floating" ];
    wayland = [ ];
  };

  hotkeys = {
    xorg = {
      "super + w" = "wall-d -R -f -d ~/Pictures/backgrounds";
    };
    wayland = {
      "Super + W" = "spawn 'wall-d -R -f -d ~/Pictures/backgrounds'";
    };
  };
in
mkModule config "walld" {
  environment.packages = with pkgs; [
    (nsxiv.override { conf = lib.readFile ./nsxiv.conf.h; })
    walld
  ];

  protocol.rules = rules."${config.protocol.type}";
  protocol.hotkeys = hotkeys."${config.protocol.type}";
}
