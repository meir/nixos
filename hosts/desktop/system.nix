{
  nixpkgs-unstable,
  home-manager,
  stylix,
  ...
}:
specialArgs:
nixpkgs-unstable.lib.nixosSystem {
  system = "x86_64-linux";
  inherit specialArgs;

  modules = [
    ./hardware-configuration.nix
    ../../system
    ./configuration.nix
    home-manager.nixosModules.home-manager
    # stylix.nixosModules.stylix
  ];
}
