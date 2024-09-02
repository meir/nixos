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
  };

  modules = [
    ./hardware-configuration.nix
    ./configuration.nix
    ../../system/linux
  ];
}
