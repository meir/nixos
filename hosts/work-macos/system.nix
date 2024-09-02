{ nix-darwin, unstable, ... }:
nix-darwin.lib.darwinSystem {
  system = "aarch64-darwin";

  specialArgs = {
    inherit unstable;
  };

  modules = [
    ../../system/darwin
    ./configuration.nix
  ];
}
