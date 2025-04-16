let
  release = "24.11";
in
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-${release}";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-${release}";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix/release-${release}";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.inputs.home-manager.follows = "home-manager";

    # Overlays
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
    izu.url = "github:meir/izu";
    nh.url = "github:viperML/nh";

    # Darwin
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs =
    inputs:
    let
      specialArgs = {
        inherit (inputs)
          nixpkgs-unstable
          nixpkgs-xr
          izu
          nh
          ;
      };
    in
    {
      nixosConfigurations = {
        desktop = import ./hosts/desktop/system.nix inputs specialArgs;
      };
      darwinConfigurations = {
        work-laptop = import ./hosts/work-macos/system.nix inputs specialArgs;
      };
    };
}
