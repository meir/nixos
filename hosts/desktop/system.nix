{
  nixpkgs,
  base16,
  stylix,
  nixpkgs-xr,
  nix-fs,
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
    nix-fs.nixosModules.nix-fs
  ];
}
