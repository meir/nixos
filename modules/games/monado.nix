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
      
      wlx-overlay-s
      wayvr-dashboard
      lovr
      lovr-playspace
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
        XRT_COMPOSITOR_SCALE_PERCENTAGE = "200";
        XRT_COMPOSITOR_DESIRED_MODE = "1";
        U_PACING_COMP_PRESENT_TO_DISPLAY_OFFSET = "5";
        U_PACING_APP_USE_MIN_FRAME_PERIOD = "1";
      };
    };

    # Bigscreen beyond patches
    boot.kernelPackages = pkgs.linuxPackagesFor (
      pkgs.linux_6_17.override {
        argsOverride = rec {
          src = pkgs.fetchurl {
            url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
            hash = "sha256-PsyGGdiltfZ1Ik0vUscdH8Cbw/nAGdi9gtBYHgNolJk=";
          };
          version = "6.17.3";
          modDirVersion = "6.17.3";
        };
      }
    );

    boot.kernelPatches = [
      {
        name = "0001-drm-edid-parse-DRM-VESA-dsc-bpp-target";
        patch = ./patches/0001-drm-edid-parse-DRM-VESA-dsc-bpp-target.patch;
      }
      {
        name = "0002-drm-amd-use-fixed-dsc-bits-per-pixel-from-edid";
        patch = ./patches/0002-drm-amd-use-fixed-dsc-bits-per-pixel-from-edid.patch;
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

    files = {
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
