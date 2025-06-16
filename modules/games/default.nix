{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.steam.enable = mkEnableOption "steam";
  options.modules.steamvr = {
    enable = mkEnableOption "SteamVR support";
    runtime = mkOption {
      type = types.enum [
        "steamvr"
        "monado"
      ];
      default = "steamvr";
    };
  };

  imports = [
    ./steamvr.nix
    ./monado.nix
  ];

  config = mkIf config.modules.steam.enable {
    environment.systemPackages = with pkgs; [
      protonup-qt
      protontricks
      appimage-run
      usbutils
      steamtinkerlaunch
      r2modman
      ffmpeg # add ffmpeg for ingame video players
      lutris
      wine

      # needed for steamtinkerlaunch
      gawk
      git
      ripgrep
      unzip
      wget
      xdotool
      xorg.xprop
      xorg.xrandr
      unixtools.xxd
      xorg.xwininfo
      yad
    ];

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

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
      package = with pkgs; steam.override { extraPkgs = pkgs: [ attr ]; };
    };

    desktop.entry.vortex = {
      name = "Vortex Mod Manager";
      comment = "Vortex Mod Manager for Nexus Mods";
      exec = "${lib.getExe pkgs.steam-run} ${lib.getExe pkgs.steamtinkerlaunch} vortex start";
    };

    hardware.steam-hardware.enable = true;
  };
}
