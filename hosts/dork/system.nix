{
  nixpkgs,
  nixpkgs-xr,
  nix-fs,
  steam-config-nix,
  spicetify-nix,
  milk-grub,
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
    spicetify-nix.nixosModules.default
    milk-grub.nixosModule

    ./hardware-configuration.nix
    ../../system
    ./configuration.nix
    ./steam.nix
  ];
}
