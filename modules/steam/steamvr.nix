{
  config,
  lib,
  pkgs,
  mkModule,
  ...
}:
mkModule config "steamvr" (
  with lib;
  {
    environment.packages = with pkgs; [
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

    xdg.mime = {
      enable = true;
      addedAssociations = {
        "x-scheme-handler/steamvr" = "valve-URI-steamvr.desktop";
        "x-scheme-handler/vrmonitor" = "valve-URI-vrmonitor.desktop";
      };
    };

    environment.file.wlx_overlay_s = {
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
      target = ".local/share/applications/WLXOverlayS.desktop";
    };

    bspwm.rules = [
      "bspc rule -a 'SteamVR' state=floating"
      "bspc rule -a 'SteamVR Monitor' state=floating"
    ];

    environment.file.wlx_keyboard = {
      source = ./wlxoverlay/keyboard.yaml;
      target = ".config/wlxoverlay/keyboard.yaml";
    };

    environment.file.wlx_watch = {
      source = ./wlxoverlay/watch.yaml;
      target = ".config/wlxoverlay/watch.yaml";
    };
  }
)
