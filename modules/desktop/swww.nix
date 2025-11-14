{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    swww
    waypaper
  ];

  protocol.autostart = [
    "${pkgs.swww}/bin/swww-daemon"
    "${lib.getExe pkgs.swww} restore"
  ];
}
