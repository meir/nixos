{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    mako
  ];

  protocol.autostart = [
    "${lib.getExe pkgs.mako}"
  ];

  files.".config/mako/config".source = ../config/mako/config;
}
