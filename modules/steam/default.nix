{
  config,
  options,
  pkgs,
  lib,
  nixpkgs-xr,
  ...
}:
lib.mkModule "steam" {
  imports = [ ./steamvr.nix ];

  environment.packages = with pkgs; [
    steam
    protonup-ng
    ffmpeg # add ffmpeg for ingame video players
  ];

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
}
