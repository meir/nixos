{ config, options, pkgs, lib, ... }:
with lib; {
  options.modules.steam.enable = mkOption {
    type = types.bool;
    default = true;
  };

  config = mkIf config.modules.steam.enable {
    modules.packages = with pkgs; [ steam ];

    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [ "steam" "steam-original" "steam-run" ];

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };

    hardware.steam-hardware.enable = true;
  };
}
