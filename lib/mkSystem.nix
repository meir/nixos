{
  nixpkgs,
  unstable,
  nixpkgs-xr,
  ...
}@inputs:
system: name:
nixpkgs.lib.nixosSystem (
  let
    mkModule = import ./mkModule.nix { lib = nixpkgs.lib; };

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
      inherit nixpkgs-xr;
      inherit mkModule;
    };

    modules = [
      ./file.nix

      overlayModule
      nixpkgs-xr.nixosModules.nixpkgs-xr
      ../modules
      ../hosts/${name}/hardware-configuration.nix
      ../hosts/${name}/configuration.nix
    ];
  }
)
