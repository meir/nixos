{ ... }@inputs:
{
  nixpkgs.overlays = [
    (import ./nixpkgs-unstable.nix inputs)
    (import ./nixpkgs-xr.nix inputs)
    (import ./packages.nix inputs)
  ];
}
