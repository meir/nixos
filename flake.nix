{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs: {
    nixosConfigurations = {
      desktop = import ./hosts/desktop/system.nix inputs;
      work-dell = import ./hosts/work-dell/system.nix inputs;
    };
    darwinConfigurations = {
      work-laptop = import ./hosts/work-macos/system.nix inputs;
    };
  };
}
