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

    desktop.entry.nexusmods = {
      name = "Nexus Mods App";
      comment = "The Nexus Mods App";
      exec = "NexusMods.App";
    };
  };
}
