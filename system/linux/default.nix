{ pkgs, ... }:
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
    ./protocol.nix
    ./file.nix

    ../../overlays
    ../../modules/common
    ../../modules/linux
    ../../themes
    ../../lib/file.nix
  ];

  environment.defaultPackages = with pkgs; [
    git
    curl
  ];

  system.stateVersion = "24.05";
}
