{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Overlays
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
    izu.url = "github:meir/izu";

    # Darwin
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nh.url = "github:viperML/nh";
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
        server = import ./hosts/hp-server/system.nix inputs specialArgs;
      };
      darwinConfigurations = {
        work-laptop = import ./hosts/work-macos/system.nix inputs specialArgs;
      };
    };
}
