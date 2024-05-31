{ unstable, ... }@inputs:
system: name:
inputs.nixpkgs.lib.nixosSystem (let
  overlay = final: prev: {
    unstable = import unstable {
      inherit system;
      config.allowUnfree = true;
    };
  };

  overlayModule = ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay ]; });
in {
  inherit system;
  specialArgs = { inherit unstable; };
  modules = [
    ./file.nix

    overlayModule
    ../hosts/${name}/hardware-configuration.nix
    ../hosts/${name}/configuration.nix
  ];
})
