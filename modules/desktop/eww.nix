{ 
  pkgs,
  lib,
  widgets ? [],
  ...
}:
with lib;
let
  widgetScripts = pkgs.writeScript "eww-start" (
    concatStringsSep "\n" (
      map (widget: ''
        ${pkgs.eww}/bin/eww open ${widget}
      '') widgets
    )
  );
in
{
  environment.systemPackages = with pkgs; [
    jq
    eww
    zscroll
  ];

  protocol.autostart = [
    "${pkgs.eww}/bin/eww daemon &"
    "${widgetScripts}"
  ];

  files.".config/eww".source = ../config/eww;
}
