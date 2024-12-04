{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  vrpathreg = "${config.user_home}/.steam/steam/steamapps/common/SteamVR/bin/vrpathreg.sh";
in
{
  options.modules.steamvr.enable = mkEnableOption "SteamVR support";

  config = mkIf config.modules.steamvr.enable {
    environment.systemPackages = with pkgs; [ wlx-overlay-s ];

    environment.variables = {
      STEAMVR_EMULATE_INDEX_CONTROLLER = "1";
      STEAMVR_LH_ENABLE = "1";
      XRT_COMPOSITOR_COMPUTE = "1";
    };

    services.monado = {
      enable = true;
      defaultRuntime = true;
    };

    boot.extraModprobeConfig = ''
      options nvidia_drm modeset=1
      options nvidia_drm fbdev=1
      options nvidia NVreg_PreserveVideoMemoryAllocations=1
      options nvidia NVreg_EnableGpuFirmware=0
    '';

    protocol.autostart = [
      ''[ -f "${vrpathreg}" ] && ${getExe pkgs.steam-run} ${vrpathreg} adddriver ${pkgs.monado}/share/steamvr-monado''
    ];

    protocol.rules = [
      "bspc rule -a 'SteamVR' state=floating"
      "bspc rule -a 'SteamVR Monitor' state=floating"
    ];

    hm.home.file = {
      ".config/wlxoverlay/keyboard.yaml".source = ../../config/wlxoverlay/keyboard.yaml;
      ".config/wlxoverlay/watch.yaml".source = ../../config/wlxoverlay/watch.yaml;
    };

    desktop.entry = {
      wlx-overlay-s = {
        name = "WLX Overlay S";
        comment = "WLX Overlay for SteamVR";
        exec = "${pkgs.wlx-overlay-s}/bin/wlx-overlay-s --replace";
      };
    };
  };
}
