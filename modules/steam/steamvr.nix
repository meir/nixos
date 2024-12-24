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
    environment.systemPackages = with pkgs; [ wlx-overlay-s ];

    boot.extraModprobeConfig = ''
      options nvidia_drm modeset=1
      options nvidia_drm fbdev=1
      options nvidia NVreg_PreserveVideoMemoryAllocations=1
      options nvidia NVreg_EnableGpuFirmware=0
    '';

    # protocol.rules = [
    #   "bspc rule -a 'SteamVR' state=floating"
    #   "bspc rule -a 'SteamVR Monitor' state=floating"
    # ];

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
