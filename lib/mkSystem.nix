{
  nixpkgs,
  unstable,
  nixpkgs-xr,
  ...
}:
system: name:
nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = {
    mkModule = import ./mkModule.nix nixpkgs;
  };

  modules = [
    ./file.nix

    ../overlays
    ../modules
    ../themes
    ../hosts/${name}/hardware-configuration.nix
    ../hosts/${name}/configuration.nix
  ];
}
