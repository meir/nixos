{
  config,
  lib,
  pkgs,
  mkModule,
  unstable,
  ...
}:
with lib;
mkModule config "nexusmods" {
  environment.packages = with pkgs; [ unstable.nexusmods-app ];

  environment.file.nexusmods = {
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
