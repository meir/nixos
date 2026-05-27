{
  pkgs,
  lib,
  ...
}:
with lib;
{
  environment.systemPackages = with pkgs; [
    protonup-qt
    protontricks
    appimage-run
    ffmpeg # add ffmpeg for ingame video players

    wine
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
          libXcursor
          libXi
          libXinerama
          libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
          attr
          ndi-6
        ];
    };
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  hardware.steam-hardware.enable = true;
}
