{ nixpkgs, home-manager, ... }:
specialArgs:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  inherit specialArgs;

  modules = [
    ./hardware-configuration.nix
    ./configuration.nix
    ../../system
    home-manager.nixosModules.home-manager
  ];
}
