{ 
  pkgs,
  lib,
  assets,
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

  nix-fs.files.".config/cwal/templates".source = "${assets.cwal}/templates";
  nix-fs.files.".config/cwal/cwal.ini".source = assets.cwal_config;
  nix-fs.files.".config/quickshell/shell.qml".source = assets.quickshell_config;
  nix-fs.files.".config/quickshell/src".source = "${assets.quickshell}/src";
}
