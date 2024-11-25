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

    hardware.opengl.extraPackages = [ pkgs.unstable.monado-vulkan-layers ];

    environment.variables = {
      STEAMVR_EMULATE_INDEX_CONTROLLER = "1";
      STEAMVR_LH_ENABLE = "1";
    };

    services.monado = {
      enable = true;
      defaultRuntime = true;
    };

    programs.envision.enable = true;

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

          mkdir -p ${config.user_home}/.local/share/monado
          ${getExe pkgs.git} clone https://gitlab.freedesktop.org/monado/utilities/hand-tracking-models ${config.user_home}/.local/share/monado/hand-tracking-models
        '';
        wantedBy = [ "multi-user.target" ];
      };

    protocol.rules = [
      "bspc rule -a 'SteamVR' state=floating"
      "bspc rule -a 'SteamVR Monitor' state=floating"
    ];

    hm.home.file = {
      ".local/share/openxr/1/active_runtime.json".source = "${pkgs.monado}/share/openxr/1/openxr_monado.json";
      ".local/share/openvr/openvrpaths.vrpath".text = ''
        {
          "config": [
            "${config.user_home}/Steam/config"
          ],
          "external_drivers": null,
          "jsonid": "vrpathreg",
          "log": [
            "${config.user_home}/Steam/logs"
          ],
          "runtime": [
            "${pkgs.opencomposite}/lib/opencomposite"
          ],
          "version": 1
        }
      '';

      ".local/share/applications/WLXOverlayS.desktop" = {
        text = ''
          [Desktop Entry]
          Name=WLX Overlay S
          Comment=WLX Overlay for SteamVR
          Exec=steam-run ${pkgs.wlx-overlay-s}/bin/wlx-overlay-s --replace
          Icon=${pkgs.wlx-overlay-s}/wlx-overlay-s.png
          Terminal=false
          Type=Application
          Categories=Utility;
        '';
      };

      ".local/share/applications/StartMonado.desktop" = {
        text = ''
          [Desktop Entry]
          Name=Start Monado
          Comment=Start Monado
          Exec=systemctl --user start monado.service
          Icon=${pkgs.monado}/share/monado/icons/monado.svg
          Terminal=false
          Type=Application
          Categories=Utility;
        '';
      };

      ".local/share/applications/StopMonado.desktop" = {
        text = ''
          [Desktop Entry]
          Name=Stop Monado
          Comment=Stop Monado
          Exec=systemctl --user stop monado.service
          Icon=${pkgs.monado}/share/monado/icons/monado.svg
          Terminal=false
          Type=Application
          Categories=Utility;
        '';
      };

      ".config/wlxoverlay/keyboard.yaml" = {
        source = ../../config/wlxoverlay/keyboard.yaml;
      };

      ".config/wlxoverlay/watch.yaml" = {
        source = ../../config/wlxoverlay/watch.yaml;
      };
    };
  };
}
