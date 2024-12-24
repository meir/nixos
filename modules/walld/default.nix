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
      (nsxiv.override { conf = lib.readFile ../../config/nsxiv/nsxiv.conf.h; })
      walld
    ];

    protocol.rules = rules."${config.protocol.type}";
    protocol.hotkeys = [
      ''
        Super + w
          hyprland | exec, "not implemented yet"
          wall-d -R -f -d ~/Pictures/backgrounds
      ''
    ];
  };
}
