{
  nixpkgs,
  unstable,
  nixpkgs-xr,
  home-manager,
  osx-kvm,
  izu,
  ...
}:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";

  specialArgs = {
    inherit unstable;
    inherit nixpkgs-xr;
    inherit osx-kvm;
    inherit izu;
  };

  modules = [
    ./hardware-configuration.nix
    ./configuration.nix
    ../../system/linux
    home-manager.nixosModules.home-manager
  ];
}
