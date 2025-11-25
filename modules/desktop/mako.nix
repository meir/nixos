{ pkgs, lib, config_files ? null, ... }:
with lib;
let
  mako_bin = getExe pkgs.mako;
in
{
  environment.systemPackages = with pkgs; [
    mako
  ];

  protocol.autostart = [ mako_bin ];
  nix-fs.files.".config/mako/config".source = mkIf (config_files != null) config_files;
}
