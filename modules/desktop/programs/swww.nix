{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    swww
  ];

  niri.autostart = [
    "${pkgs.swww}/bin/swww-daemon"
    "${lib.getExe pkgs.swww} restore"
  ];
}
