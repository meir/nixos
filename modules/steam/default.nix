{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
{
  options.modules.steam.enable = mkEnableOption "steam";

  imports = [ ./steamvr.nix ];

  config = mkIf config.modules.steam.enable {
    environment.systemPackages = with pkgs; [
      steam
      protonup-qt
      protontricks
      appimage-run
      steamtinkerlaunch
      r2modman
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

    desktop.entry.vortex = {
      name = "Vortex Mod Manager";
      comment = "Vortex Mod Manager for Nexus Mods";
      exec = "${lib.getExe pkgs.steam-run} ${lib.getExe pkgs.steamtinkerlaunch} vortex start";
    };

    hardware.steam-hardware.enable = true;
  };
}
