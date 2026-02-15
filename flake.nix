{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    steam-config-nix.url = "github:different-name/steam-config-nix";
    nix-fs.url = "github:meir/nix-fs";
    quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    niri.url = "github:YaLTeR/niri/v25.11";

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
          nixpkgs-xr
          izu
          nh
          zen-browser
          steam-config-nix
          nix-fs
          quickshell
          niri
          ;
      };
    in
    {
      nixosConfigurations = {
        dork = import ./hosts/dork/system.nix inputs specialArgs;
        glorp = import ./hosts/glorp/system.nix inputs specialArgs;
      };
    };
}
