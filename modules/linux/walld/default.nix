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
{
  options.modules.walld.enable = mkEnableOption "walld";

  config = mkIf config.modules.walld.enable {
    environment.systemPackages = with pkgs; [
      (nsxiv.override { conf = lib.readFile ./nsxiv.conf.h; })
      walld
    ];

    protocol.rules = rules."${config.protocol.type}";
    protocol.hotkeys = {
      "super + w" = "wall-d -R -f -d ~/Pictures/backgrounds";
    };
  };
}
