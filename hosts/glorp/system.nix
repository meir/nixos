{
  nixpkgs,
  nixpkgs-xr,
  nix-fs,
  steam-config-nix,
  millennium,
  ...
}:
specialArgs:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  inherit specialArgs;

  modules = [
    nixpkgs-xr.nixosModules.nixpkgs-xr
    nix-fs.nixosModules.nix-fs
    steam-config-nix.nixosModules.default
    millennium.overlays.default

    ./hardware-configuration.nix
    ../../system
    ./configuration.nix
  ];
}
