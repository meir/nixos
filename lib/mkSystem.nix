{
  nixpkgs,
  unstable,
  nixpkgs-xr,
  ...
}:
nix: system: name:
nix {
  inherit system;
  specialArgs = {
    inherit unstable;
    inherit nixpkgs-xr;
    mkModule = import ./mkModule.nix nixpkgs;
  };

  modules = [
    ./file.nix

    ../overlays
    ../system
    ../modules
    ../themes
    ../hosts/${name}/hardware-configuration.nix
    ../hosts/${name}/configuration.nix
  ];
}
