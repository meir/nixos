{
  nix-darwin,
  home-manager,
  nix-homebrew,
  ...
}:
specialArgs:
nix-darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  inherit specialArgs;

  modules = [
    ../../darwin/system
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
