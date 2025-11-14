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
    base16.nixosModule
    stylix.nixosModules.stylix
    nixpkgs-xr.nixosModules.nixpkgs-xr

    # remove once theres an alternative for nix managed dotfiles
    home-manager.nixosModules.home-manager
  ];
}
