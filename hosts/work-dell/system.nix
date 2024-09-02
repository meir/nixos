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
    mkModule = import ../../lib/mkModule.nix nixpkgs;
  };

  modules = [
    ../../system/linux
    ./hardware-configuration.nix
    ./configuration.nix
  ];
}
