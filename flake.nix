{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs: {
    nixosConfigurations = {
      desktop = import ./hosts/desktop/system.nix inputs;
      server = import ./hosts/hp-server/system.nix inputs;
    };
    darwinConfigurations = {
      work-laptop = import ./hosts/work-macos/system.nix inputs;
    };
  };
}
