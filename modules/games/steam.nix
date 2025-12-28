{
  pkgs,
  lib,
  config,
  apps ? [],
  ...
}:
with lib;
{
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
    capSysNice = false;
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
    package = pkgs.steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
          attr
        ];
    };
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  desktop.entry.vortex = {
    name = "Vortex Mod Manager";
    comment = "Vortex Mod Manager for Nexus Mods";
    exec = "${lib.getExe pkgs.steam-run} ${lib.getExe pkgs.steamtinkerlaunch} vortex start";
  };

  hardware.steam-hardware.enable = true;
}
