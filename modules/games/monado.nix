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
{
  environment.systemPackages = with pkgs; [
    unstable.wayvr
    lighthouse-steamvr
    monado_start
    
    lovr-playspace
    baballonia-git
  ];

  services.monado = {
    enable = true;
    defaultRuntime = true;
    highPriority = true;
    package = pkgs.monado_custom;
  };

  systemd.user.services.monado = {
    serviceConfig.LimitNOFILE = 8192;
    environment = {
      STEAMVR_LH_ENABLE = "true";
      XRT_COMPOSITOR_COMPUTE = "1";
      XRT_COMPOSITOR_SCALE_PERCENTAGE = "150";
      XRT_COMPOSITOR_DESIRED_MODE = "0";
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
    ".config/openxr/1/active_runtime.json".source = "${pkgs.monado_custom}/share/openxr/1/openxr_monado.json";
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
          "${pkgs.xrizer_custom}/lib/xrizer",
          "${pkgs.opencomposite}/lib/opencomposite"
        ],
        "version" : 1
      }
    '';
    ".config/wlxoverlay/watch.yaml".source = mkIf (watch != null) watch;
    ".config/wlxoverlay/keyboard.yaml".source = mkIf (keyboard != null) keyboard;
    ".config/wlxoverlay/config.yaml".source = mkIf (config_file != null) config_file;
    ".local/share/LOVR/lovr-playspace/grid_top.txt".text = ''
      0.0
    '';
  };

  desktop.entry = {
    wayvr = {
      name = "WayVR";
      comment = "WayVR";
      exec = "${pkgs.unstable.wayvr}/bin/wayvr --replace --openxr";
    };
    baballonia = {
      name = "Baballonia";
      comment = "Baballonia Eye/Face tracking";
      exec = "${pkgs.baballonia-git}/bin/baballonia";
    };
  };
}
