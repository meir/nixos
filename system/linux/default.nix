{ pkgs, ... }@inputs:
{
  imports = [
    ./file.nix
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
    ./home.nix

    ../../modules/common
    ../../modules/linux
    ../../themes
  ];

  nixpkgs.overlays = [
    (import ../overlays/nixpkgs-unstable.nix inputs)
    (import ../overlays/nixpkgs-xr.nix inputs)
    (import ../packages.nix inputs)
  ];

  environment.defaultPackages = with pkgs; [
    git
    curl
  ];

  system.stateVersion = "24.05";
}
