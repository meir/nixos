{ options, config, pkgs, lib, ... }:
with lib;
let
  enableVr = options.modules.steamvr.enable;
in
{
  options.modules.steamvr.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf enableVr {
    environment.packages = [
      appimage-run
      monado
      opencomposite
      wlx-overlay-s
    ];

    services.xserver.displayManager.sessionCommands =
      let
        vrpathreg = "${config.user_home}/.steam/steam/steamapps/common/SteamVR/bin/vrpathreg.sh";
      in
      ''
        if [ -f "${vrpathreg}" ]; then
          ${getExe pkgs.steam-run} ${vrpathreg} ${pkgs.monado}/share/steamvr-monado
        fi
      '';

    xdg.mime = {
      enable = true;
      addedAssociations = {
        "x-scheme-handler/steamvr" = "valve-URI-steamvr.desktop";
        "x-scheme-handler/vrmonitor" = "valve-URI-vrmonitor.desktop";
      };
    };

    bspwm.rules = [
      "bspc rule -a 'SteamVR' state=floating"
      "bspc rule -a 'SteamVR Monitor' state=floating"
    ];

    environment.file.wlx_keyboard = {
      source = ./wlxoverlay/keyboard.yaml;
      target = ".config/wlxoverlay/keyboard.yaml";
    };
  };
}
