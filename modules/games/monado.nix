{
  config,
  pkgs,
  lib,
  watch ? null,
  keyboard ? null,
  config_file ? null,
  ...
}:
with lib;
let
  monado = pkgs.monado_custom;
  xrizer = pkgs.xrizer_custom;
in
{
  environment.systemPackages = with pkgs; [
    wlx-overlay-s
    lighthouse-steamvr
    monado_start
    
    wlx-overlay-s
    wayvr-dashboard
    lovr-playspace
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
      XRT_COMPOSITOR_SCALE_PERCENTAGE = "200";
      XRT_COMPOSITOR_DESIRED_MODE = "1";
      U_PACING_COMP_PRESENT_TO_DISPLAY_OFFSET = "5";
      U_PACING_APP_USE_MIN_FRAME_PERIOD = "1";
    };
  };

  # Bigscreen Beyond Kernel patches from LVRA Discord Thread
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelPatches = [
    {
      name = "0001-drm-edid-parse-DRM-VESA-dsc-bpp-target";
      patch = ./patches/0001-drm-edid-parse-DRM-VESA-dsc-bpp-target.patch;
    }
    {
      name = "0002-drm-amd-use-fixed-dsc-bits-per-pixel-from-edid";
      patch = ./patches/0002-drm-amd-use-fixed-dsc-bits-per-pixel-from-edid.patch;
    }
    {
      name = "0001-Change-device-uvc_version-check-on-dwMaxVideoFrameSize";
      patch = ./patches/0001-Change-device-uvc_version-check-on-dwMaxVideoFrameSize.patch;
    }
  ];

  # Udev rules for Bigscreen devices
  services.udev.extraRules = ''
    # Bigscreen Beyond
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="35bd", ATTRS{idProduct}=="0101", MODE="0660", TAG+="uaccess"
    # Bigscreen Bigeye
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="35bd", ATTRS{idProduct}=="0202", MODE="0660", TAG+="uaccess", GROUP="users"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="35bd", ATTRS{idProduct}=="0202", MODE="0660", TAG+="uaccess", GROUP="users"
    # Bigscreen Beyond Audio Strap
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="35bd", ATTRS{idProduct}=="0105", MODE="0660", TAG+="uaccess"
    # Bigscreen Beyond Firmware Mode?
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="35bd", ATTRS{idProduct}=="4004", MODE="0660", TAG+="uaccess"
  '';

  nix-fs.files = {
    ".config/openxr/1/active_runtime.json".source = "${monado}/share/openxr/1/openxr_monado.json";
    ".config/openvr/openvrpaths.vrpath".text = ''
      {
        "config" :
        [
          "${config.home}/.local/share/Steam/config"
        ],
        "external_drivers" : null,
        "jsonid" : "vrpathreg",
        "log" :
        [
          "${config.home}/.local/share/Steam/logs"
        ],
        "runtime" :
        [
          "${xrizer}/lib/xrizer",
          "${pkgs.opencomposite}/lib/opencomposite"
        ],
        "version" : 1
      }
    '';
    ".config/wlxoverlay/watch.yaml".source = mkIf (watch != null) watch;
    ".config/wlxoverlay/keyboard.yaml".source = mkIf (keyboard != null) keyboard;
    ".config/wlxoverlay/config.yaml".source = mkIf (config_file != null) config_file;
  };

  desktop.entry = {
    wlx-overlay-s = {
      name = "WLX Overlay S";
      comment = "WLX Overlay for SteamVR";
      exec = "${pkgs.wlx-overlay-s}/bin/wlx-overlay-s --replace --openxr";
    };
  };
}
