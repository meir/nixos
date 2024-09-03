{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.modules.steamvr.enable = mkEnableOption "SteamVR support";

  config = mkIf config.modules.steamvr.enable {
    environment.systemPackages = with pkgs; [
      appimage-run
      monado
      opencomposite
      wlx-overlay-s
    ];

    systemd.user.services.register_steamvr_monado =
      let
        vrpathreg = "${config.user_home}/.steam/steam/steamapps/common/SteamVR/bin/vrpathreg.sh";
      in
      {
        description = "register Monado using the SteamVR pathreg";
        script = ''
          if [ -f "${vrpathreg}" ]; then
            ${getExe pkgs.steam-run} ${vrpathreg} ${pkgs.monado}/share/steamvr-monado
          fi
        '';
        wantedBy = [ "multi-user.target" ];
      };

    protocol.rules = [
      "bspc rule -a 'SteamVR' state=floating"
      "bspc rule -a 'SteamVR Monitor' state=floating"
    ];

    hm.home.file = {
      ".local/share/applications/WLXOverlayS.desktop" = {
        text = ''
          [Desktop Entry]
          Name=WLX Overlay S
          Comment=WLX Overlay for SteamVR
          Exec=steam-run ${pkgs.wlx-overlay-s}/bin/wlx-overlay-s
          Icon=${pkgs.wlx-overlay-s}/wlx-overlay-s.png
          Terminal=false
          Type=Application
          Categories=Utility;
        '';
      };

      ".config/wlxoverlay/keyboard.yaml" = {
        source = ./wlxoverlay/keyboard.yaml;
      };

      ".config/wlxoverlay/watch.yaml" = {
        source = ./wlxoverlay/watch.yaml;
      };
    };
  };
}
