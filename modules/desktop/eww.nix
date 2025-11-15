{ 
  pkgs,
  lib,
  widgets ? [],
  ...
}:
with lib;
let
  eww_bin = lib.getExe pkgs.eww;
  eww_widgets = map (widget: "${eww_bin} open ${widget}") widgets;
in
{
  environment.systemPackages = with pkgs; [
    eww
    jq
    zscroll
  ];

  protocol.autostart = [ "${eww_bin} daemon &" ] ++ eww_widgets;
  files.".config/eww".source = ../config/eww;
}
