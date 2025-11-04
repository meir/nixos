{
  nixpkgs,
  home-manager,
  base16,
  stylix,
  nixpkgs-xr,
  ...
}:
specialArgs:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  inherit specialArgs;

  modules = [
    ./hardware-configuration.nix
    ../../system
    ./configuration.nix
    home-manager.nixosModules.home-manager
    base16.nixosModule
    stylix.nixosModules.stylix
    nixpkgs-xr.nixosModules.nixpkgs-xr
  ];
}
