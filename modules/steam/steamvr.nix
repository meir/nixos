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

    # protocol.rules = [
    #   "bspc rule -a 'SteamVR' state=floating"
    #   "bspc rule -a 'SteamVR Monitor' state=floating"
    # ];

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

    hm.home.file = {
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
