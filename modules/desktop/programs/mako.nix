{ pkgs, lib, ... }:
with lib;
let
  mako_bin = getExe pkgs.mako;
in
{
  environment.systemPackages = with pkgs; [
    mako
  ];

  niri.autostart = [ mako_bin ];
  # use cwal to place config instead
  # nix-fs.files.".config/mako/config".source = mkIf (config_files != null) config_files;
}
