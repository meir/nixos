{ config, pkgs, lib, ... }:
let
  timezone = "Europe/Amsterdam";
  locale = "en_US.UTF-8";
in {
  imports = [
    ./audio.nix
    ./locale.nix
    ./network.nix
    ./nixos.nix
    ./security.nix
    ./user.nix
    ./fonts.nix
    ./packages.nix

    # desktop
    ./xserver.nix
    ./bspwm.nix
    ./sxhkd.nix
  ];

  environment.defaultPackages = with pkgs; [ git curl ];

  system.stateVersion = "23.11";
}
