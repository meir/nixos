{
  config,
  pkgs,
  mkModule,
  lib,
  ...
}:
with lib;
let
  xorg = config.protocol.xorg.enable;
in
mkModule config "walld" {
  environment.packages = with pkgs; [
    (nsxiv.override { conf = lib.readFile ./nsxiv.conf.h; })
    walld
  ];

  protocol.rules = mkIf xorg [ "bspc rule -a Nsxiv state=floating" ];

  protocol.hotkeys = mkIf xorg {
    "super + w" = ''
      wall-d -R -f -d ~/Pictures/backgrounds
    '';
  };
}
