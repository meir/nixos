{ pkgs, ... }@inputs:
{
  imports = [
    ./nix.nix
    ./file.nix

    ../../modules/common
    ../../modules/darwin
  ];

  nixpkgs.overlays = [
    (import ../../overlays/nixpkgs-unstable.nix inputs)
    (import ../../overlays/packages.nix inputs)
  ];

  environment.systemPackages = with pkgs; [
    git
    curl
  ];

  system.stateVersion = 4;
}
