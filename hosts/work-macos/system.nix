{ nix-darwin, home-manager, ... }:
nix-darwin.lib.darwinSystem {
  system = "aarch64-darwin";

  specialArgs = {
    mkModule = import ./mkModule.nix nix-darwin;
  };

  modules = [
    ../../system
    ./configuration.nix
    home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    }
  ];
}
