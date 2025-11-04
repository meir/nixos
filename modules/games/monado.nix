{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  monado = pkgs.monado_custom;
  xrizer = pkgs.xrizer_custom;
in
{
  config = mkIf (config.modules.steamvr.enable && config.modules.steamvr.runtime == "monado") {
    environment.systemPackages = with pkgs; [
      wlx-overlay-s
      lighthouse-steamvr
      monado_start
      
      bs-manager
      eepyxr
      wlx-overlay-s
      lovr-playspace
      resolute
    ];

    protocol.rules = [
      "windowrulev2 = workspace 5, initialTitle:(.*[vV][rR].*)" # match with any title that has "VR"
    ];

    programs.steam.extraCompatPackages = with pkgs; [ proton-ge-rtsp-bin ];

    services.monado = {
      enable = true;
      defaultRuntime = true;
      highPriority = true;
      package = monado;
    };

    systemd.user.services.monado = {
    serviceConfig.LimitNOFILE = 8192;
    environment = {
      STEAMVR_LH_ENABLE = "true";
      XRT_COMPOSITOR_COMPUTE = "1";
      U_PACING_COMP_PRESENT_TO_DISPLAY_OFFSET = "10";
      U_PACING_APP_USE_MIN_FRAME_PERIOD = "1";
      XRT_COMPOSITOR_SCALE_PERCENTAGE = "100";
      XRT_COMPOSITOR_DESIRED_MODE = "1";
      # XRT_COMPOSITOR_DESIRED_MODE=0 is the 75hz mode
      # XRT_COMPOSITOR_DESIRED_MODE=1 is the 90hz mode
    };
  };

    hm.home.file = {
      ".config/openxr/1/active_runtime.json".source = "${monado}/share/openxr/1/openxr_monado.json";
      ".config/openvr/openvrpaths.vrpath".text = ''
        {
          "config" :
          [
            "${config.user_home}/.local/share/Steam/config"
          ],
          "external_drivers" : null,
          "jsonid" : "vrpathreg",
          "log" :
          [
            "${config.user_home}/.local/share/Steam/logs"
          ],
          "runtime" :
          [
            "${xrizer}/lib/xrizer",
            "${pkgs.opencomposite}/lib/opencomposite"
          ],
          "version" : 1
        }
      '';
      ".config/wlxoverlay/watch.yaml".source = ../config/wlxoverlay/watch.yaml;
      ".config/wlxoverlay/keyboard.yaml".source = ../config/wlxoverlay/keyboard.yaml;
    };

    desktop.entry = {
      wlx-overlay-s = {
        name = "WLX Overlay S";
        comment = "WLX Overlay for SteamVR";
        exec = "${pkgs.wlx-overlay-s}/bin/wlx-overlay-s --replace --openxr";
      };
    };
  };
}
