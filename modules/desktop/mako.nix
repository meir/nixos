{ pkgs, lib, ... }:
let
  mako_bin = lib.getExe pkgs.mako;
in
{
  environment.systemPackages = with pkgs; [
    mako
  ];

  protocol.autostart = [ mako_bin ];
  files.".config/mako/config".source = ../config/mako/config;
}
