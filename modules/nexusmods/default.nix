{
  config,
  lib,
  pkgs,
  mkModule,
  ...
}:
mkModule config "nexusmods" (
  with lib;
  {
    environment.packages = with pkgs; [ nexusmods-app ];

    environment.file.wlx_overlay_s = {
      text = ''
        [Desktop Entry]
        Name=Nexus Mods App
        Comment=The Nexus Mods App
        Exec=NexusMods.App
        Terminal=false
        Type=Application
        Categories=Utility;
      '';
      target = ".local/share/applications/NexusMods.desktop";
    };
  }
)
