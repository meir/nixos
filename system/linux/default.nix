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
    ./protocol.nix
    ./home.nix

    ../../modules/common
    ../../modules/linux
    ../../themes
  ];

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (import ../../overlays/nixpkgs-unstable.nix inputs)
    (import ../../overlays/nixpkgs-xr.nix inputs)
    (import ../../overlays/packages.nix inputs)
  ];

  environment.systemPackages = with pkgs; [
    git
    curl
  ];

  system.stateVersion = "24.05";
}
