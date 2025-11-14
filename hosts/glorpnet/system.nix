{
  nixpkgs,
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
  ];
}

