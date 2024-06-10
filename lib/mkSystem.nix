{ unstable, ... }@inputs:
system: name:
inputs.nixpkgs.lib.nixosSystem (
  let
    overlay = final: prev: {
      unstable = import unstable {
        inherit system;
        config.allowUnfree = true;
      };
    };

    customPkgs = final: prev: {
      cozette-nerdfont = import ../pkgs/cozette-nerdfont final;
      dina-remastered = import ../pkgs/dina-remastered final;
      cdl = import ../pkgs/cdl final;
    };

    overlayModule = (
      { config, pkgs, ... }:
      {
        nixpkgs.overlays = [
          overlay
          customPkgs
        ];
      }
    );
  in
  {
    inherit system;
    specialArgs = {
      inherit unstable;
    };
    modules = [
      ./file.nix

      overlayModule
      ../hosts/${name}/hardware-configuration.nix
      ../hosts/${name}/configuration.nix
      ../modules
    ];
  }
)
