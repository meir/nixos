{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  environment.systemPackages = with pkgs; [ wlx-overlay-s ];

  protocol.rules = [
    "windowrulev2 = workspace 5, initialTitle:(.*[vV][rR].*)" # match with any title that has "VR"
  ];

  programs.steam.extraCompatPackages = with pkgs; [ proton-ge-rtsp-bin ];

  boot.kernelPatches = [
    {
      name = "amdgpu-ignore-ctx-privileges";
      patch = pkgs.fetchpatch {
        name = "cap_sys_nice_begone.patch";
        url = "https://github.com/Frogging-Family/community-patches/raw/master/linux61-tkg/cap_sys_nice_begone.mypatch";
        hash = "sha256-Y3a0+x2xvHsfLax/uwycdJf3xLxvVfkfDVqjkxNaYEo=";
      };
    }
  ];

  files = {
    ".config/openxr/1/active_runtime.json".text = ''
      {
        "file_format_version": "1.0.0",
        "runtime": {
          "VALVE_runtime_is_steamvr": true,
          "library_path": "/home/${config.user}/.local/share/Steam/steamapps/common/SteamVR/bin/linux64/vrclient.so",
          "name": "SteamVR"
        }
      }
    '';
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
          "${config.home}/.local/share//Steam/logs"
        ],
        "runtime" :
        [
          "${config.home}/.local/share/Steam/steamapps/common/SteamVR"
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
      exec = "${pkgs.wlx-overlay-s}/bin/wlx-overlay-s --replace";
    };
  };
}
