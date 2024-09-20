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
  };

  modules = [
    ./hardware-configuration.nix
    ./configuration.nix
    ../../system/linux
    home-manager.nixosModules.home-manager
  ];
}
