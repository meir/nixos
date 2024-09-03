{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.modules.nexusmods.enable = mkEnableOption "nexusmods";

  config = mkIf config.modules.nexusmods.enable {
    environment.systemPackages = with pkgs; [ unstable.nexusmods-app ];

    hm.home.file.".local/share/applications/NexusMods.desktop" = {
      text = ''
        [Desktop Entry]
        Name=Nexus Mods App
        Comment=The Nexus Mods App
        Exec=NexusMods.App
        Terminal=false
        Type=Application
        Categories=Utility;
      '';
    };
  };
}
