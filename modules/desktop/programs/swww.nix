{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    awww
  ];

  niri.autostart = [
    "${pkgs.awww}/bin/awww-daemon"
    "${lib.getExe pkgs.awww} restore"
  ];
}
