{
  nixpkgs,
  unstable,
  nixpkgs-xr,
  ...
}@inputs:
system: name:
nixpkgs.lib.nixosSystem (
  let
    extraPackages = (
      { config, pkgs, ... }:
      {
        nixpkgs.overlays = [
          (final: prev: {
            unstable = import unstable (final // { config.allowUnfree = true; });
            cozette-nerdfont = import ../pkgs/cozette-nerdfont final;
            dina-remastered = import ../pkgs/dina-remastered final;
            cdl = import ../pkgs/cdl final;
            picom-ftlabs = import ../pkgs/picom-ftlabs final;
            walld = import ../pkgs/walld final;
          })
        ];
      }
    );
  in
  {
    inherit system;
    specialArgs = {
      inherit nixpkgs-xr;

      unstable = import unstable (
        nixpkgs
        // {
          inherit system;
          config.allowUnfree = true;
        }
      );
      mkModule = import ./mkModule.nix nixpkgs;
      replace = import ./replace nixpkgs;
    };

    modules = [
      ./file.nix

      extraPackages
      nixpkgs-xr.nixosModules.nixpkgs-xr
      ../modules
      ../themes
      ../hosts/${name}/hardware-configuration.nix
      ../hosts/${name}/configuration.nix
    ];
  }
)
