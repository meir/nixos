{
  nix-darwin,
  unstable,
  home-manager,
  ...
}:
nix-darwin.lib.darwinSystem {
  system = "aarch64-darwin";

  specialArgs = {
    inherit unstable;
  };

  modules = [
    ../../system/darwin
    ./configuration.nix
    home-manager.darwinModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = false;
      home-manager.users.meir.home.stateVersion = "24.05";
    }
  ];
}
