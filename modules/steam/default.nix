{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.steam = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };

    steamvr.enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf config.modules.steam.enable {

    environment.packages =
      with pkgs;
      let
        vrPackages =
          if config.modules.steam.steamvr.enable then
            [
              openvr
              appimage-run
              fuse
              wlx-overlay-s
              monado
            ]
          else
            [ ];
      in
      [
        steam
        ffmpeg # add ffmpeg for ingame video players
      ]
      ++ vrPackages;

    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "steam"
        "steam-original"
        "steam-run"
      ];

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };

    hardware.steam-hardware.enable = true;

    # patch steamvr
    services.xserver.displayManager.sessionCommands = mkIf config.modules.steam.steamvr.enable (
      let
        vrcompositor = "${config.user_home}/.local/share/Steam/steamapps/common/SteamVR/bin/linux64/vrcompositor-launcher";
      in
      ''
        if [ -f "${vrcompositor}" ]; then
          setcap CAP_SYS_NICE+ep ${vrcompositor}
        fi
      ''
    );

    environment.file.wlx_keyboard = mkIf config.modules.steam.steamvr.enable {
      source = ./keyboard.yaml;
      target = ".config/wlxoverlay/keyboard.yaml";
    };
  };
}
