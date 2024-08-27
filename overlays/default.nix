{ ... }:
{
  nixpkgs.overlays = [
    ./packages.nix
    ./nixpkgs-unstable.nix
    ./nixpkgs-xr.nix
  ];
}
