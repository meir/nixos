{
  nixpkgs,
  unstable,
  nixpkgs-xr,
  home-manager,
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
    ../../system
    home-manager.nixosModules.home-manager
  ];
}
