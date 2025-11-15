{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    stylix.url = "github:danth/stylix/release-25.05";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    base16.url = "github:SenchoPens/base16.nix";

    # only use for dotfiles; remove as soon as theres an alternative
    home-manager.url = "github:nix-community/home-manager/release-25.05";

    # Overlays
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
    izu.url = "github:meir/izu";
    nh.url = "github:viperML/nh";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs =
    inputs:
    let
      specialArgs = {
        modules = import ./lib/modules.nix;
        inherit (inputs)
          nixpkgs-unstable
          izu
          nh
          zen-browser
          home-manager
          ;
      };
    in
    {
      nixosConfigurations = {
        desktop = import ./hosts/desktop/system.nix inputs specialArgs;
        glorpnet = import ./hosts/glorpnet/system.nix inputs specialArgs;
      };
    };
}
