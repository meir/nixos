{ 
  pkgs,
  lib,
  cwal_config ? null,
  cwal_templates ? null,
  quickshell_config ? null,
  ...
}:
with lib;
{
  environment.systemPackages = with pkgs; [
    (quickshell.overrideAttrs (prevAttrs: {
      buildInputs = [ qml-niri ] ++ prevAttrs.buildInputs;
    }))
    jq
    zscroll
    cwal
  ];

  niri.autostart = [
    "qs -d"
  ];

  niri.hotkeys = {
    "Super+W".spawn = "quickshell ipc call WallpaperPicker open";
  };

  nix-fs.files.".config/cwal/templates".source = mkIf (cwal_templates != null) cwal_templates;
  nix-fs.files.".config/cwal/cwal.ini".source = mkIf (cwal_config != null) cwal_config;
  nix-fs.files.".config/quickshell/shell.qml".source = mkIf (quickshell_config != null) "${quickshell_config}/shell.qml";
  nix-fs.files.".config/quickshell/src".source = mkIf (quickshell_config != null) "${quickshell_config}/src";
}
