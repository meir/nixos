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

    services.monado = {
      enable = true;
      defaultRuntime = true;
      package = pkgs.monado;
    };

    systemd.user.services.monado.environment = {
      STEAMVR_LH_ENABLE = "1";
      XRT_COMPOSITOR_COMPUTE = "1";
    };

    hm.home.file = {
      ".config/openxr/1/active_runtime.json".source = "${pkgs.monado}/share/openxr/1/openxr_monado.json";
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
            "${config.user_home}/.local/share//Steam/logs"
          ],
          "runtime" :
          [
            "${pkgs.opencomposite}/lib/opencomposite"
          ],
          "version" : 1
        }
      '';
      ".local/share/monado/hand-tracking-models".source = pkgs.fetchgit {
        url = "https://gitlab.freedesktop.org/monado/utilities/hand-tracking-models.git";
        fetchLFS = true;
        sha256 = "sha256-x/X4HyyHdQUxn3CdMbWj5cfLvV7UyQe1D01H93UCk+M=";
      };
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
