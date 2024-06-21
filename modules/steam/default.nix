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
  };

  imports = [ ./steamvr.nix ];

  config = mkIf config.modules.steam.enable {
    environment.packages = with pkgs; [
      steam
      protonup-qt
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
  };
}
