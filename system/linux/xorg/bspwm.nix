{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
let
  buildBspwm = pkgs.writeScript "bspwmrc" (
    concatStringsSep "\n\n" ([ "#!/bin/sh" ] ++ config.protocol.rules ++ config.protocol.autostart)
  );
in
{
  config = mkIf (config.protocol.xorg.enable && config.protocol.xorg.wm == "bspwm") {
    services.xserver.windowManager.bspwm = {
      enable = true;
      configFile = buildBspwm;
    };

    protocol.hotkeys = {
      # close, kill app
      "super + {_,shift + }q" = ''
        bspc node -{c,k}
      '';

      # switch between modes
      "super + m" = ''
        bspc desktop -l next
      '';

      # change mode
      "super + {t,shift + t,s,f}" = ''
        bspc node -t {tiled,pseudo_tiled,floating,fullscreen}
      '';

      # set flag
      "super + shift + {m,x,y,z}" = ''
        bspc node -g {marked,locked,sticky,private}
      '';

      # focus/move the node in given direction
      "super + {_,shift + }{h,j,k,l}" = ''
        bspc node -{f,s} {west,south,north,east}
      '';

      # move (node) to desktop
      "super + {_,shift + }{1-9,0}" = ''
        bspc {desktop -f,node -d} '^{1-9,10}'
      '';
    };
  };
}
