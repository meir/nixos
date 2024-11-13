{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    osx-kvm.url = "github:ngi-nix/osx-kvm";
    izu.url = "github:meir/izu";
  };

  outputs =
    inputs:
    let
      specialArgs = {
        inherit (inputs)
          unstable
          nixpkgs-xr
          osx-kvm
          izu
          ;
      };
    in
    {
      nixosConfigurations = {
        desktop = import ./hosts/desktop/system.nix inputs specialArgs;
        server = import ./hosts/hp-server/system.nix inputs specialArgs;
      };
      darwinConfigurations = {
        work-laptop = import ./hosts/work-macos/system.nix inputs specialArgs;
      };
    };
}
