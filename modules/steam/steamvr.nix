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
      ".config/wlxoverlay/openxr_actions.json5".text = ''
        [
          {
            profile: "/interaction_profiles/valve/index_controller",
            pose: {
              left: "/user/hand/left/input/aim/pose",
              right: "/user/hand/right/input/aim/pose"
            },
            haptic: {
              left: "/user/hand/left/output/haptic",
              right: "/user/hand/right/output/haptic"
            },
            click: {
              left: "/user/hand/left/input/trigger/value",
              right: "/user/hand/right/input/trigger/value"
            },
            // alt_click: {
            //  right: "/user/hand/right/input/trackpad/force",
            // },
            grab: {
              left: "/user/hand/left/input/squeeze/force",
              right: "/user/hand/right/input/squeeze/force"
            },
            scroll: {
              left: "/user/hand/left/input/thumbstick/y",
              right: "/user/hand/right/input/thumbstick/y"
            },
            toggle_dashboard: {
              double_click: false,
              right: "/user/hand/right/input/system/click",
            },
            show_hide: {
              double_click: true,
              left: "/user/hand/left/input/b/click",
            },
            space_drag: {
              left: "/user/hand/left/input/trackpad/force",
              right: "/user/hand/right/input/trackpad/force",
            },
            space_reset: {
              left: "/user/hand/left/input/thumbstick/click",
            },
            click_modifier_right: {
              left: "/user/hand/left/input/b/touch",
              right: "/user/hand/right/input/b/touch"
            },
            click_modifier_middle: {
              left: "/user/hand/left/input/a/touch",
              right: "/user/hand/right/input/a/touch"
            },
            move_mouse: {
              // used with focus_follows_mouse_mode
              left: "/user/hand/left/input/trigger/touch",
              right: "/user/hand/right/input/trigger/touch"
            }
          }
        ]
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
