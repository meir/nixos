{
  config,
  options,
  pkgs,
  lib,
  nixpkgs-xr,
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
              appimage-run
              monado
              opencomposite
              wlx-overlay-s
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

    services.xserver.displayManager.sessionCommands =
      let
        vrpathreg = "${config.user_home}/.steam/steam/steamapps/common/SteamVR/bin/vrpathreg.sh";
      in
      mkIf config.modules.steam.steamvr.enable ''
        if [ -f "${vrpathreg}" ]; then
          ${lib.getExe pkgs.steam-run} ${vrpathreg} ${pkgs.monado}/share/steamvr-monado
        fi
      '';

    xdg.mime = {
      enable = true;
      addedAssociations = {
        "x-scheme-handler/steamvr" = "valve-URI-steamvr.desktop";
        "x-scheme-handler/vrmonitor" = "valve-URI-vrmonitor.desktop";
      };
    };

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };

    hardware.steam-hardware.enable = true;

    environment.file.wlx_keyboard = mkIf config.modules.steam.steamvr.enable {
      source = ./keyboard.yaml;
      target = ".config/wlxoverlay/keyboard.yaml";
    };
  };
}
