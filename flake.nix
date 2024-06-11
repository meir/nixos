{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
  };

  outputs =
    inputs:
    let
      mkSystem = import ./lib/mkSystem.nix;
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        desktop = mkSystem inputs system "desktop";
      };
    };
}
