{
  config,
  pkgs,
  lib,
  ...
}:
let
  timezone = "Europe/Amsterdam";
  locale = "en_US.UTF-8";
in
{
  imports = [
    ./bootloader.nix
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

  environment.defaultPackages = with pkgs; [
    git
    curl
    sxhkd
  ];

  system.stateVersion = "24.05";
}
