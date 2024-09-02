{
  nixpkgs,
  unstable,
  nixpkgs-xr,
  ...
}:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";

  specialArgs = {
    inherit unstable;
    inherit nixpkgs-xr;
    mkModule = import ./mkModule.nix nixpkgs;
  };

  modules = [
    ../../lib/file.nix

    ../../overlays
    ../../system
    ../../modules
    ../../themes
    ./hardware-configuration.nix
    ./configuration.nix
  ];
}
