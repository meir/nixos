
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { nixpkgs, ... }@inputs:
  let
    mkSystem = import ./lib/mkSystem.nix;
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      desktop = mkSystem inputs system "desktop";
    };
  };
}

