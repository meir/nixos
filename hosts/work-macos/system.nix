{
  nix-darwin,
  unstable,
  home-manager,
  nix-homebrew,
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
    nix-homebrew.darwinModules.nix-homebrew
    (
      { config, ... }:
      {
        nix-homebrew = {
          enable = true;
          enableRosetta = true;
          user = "${config.user}";
        };
      }
    )
  ];
}
