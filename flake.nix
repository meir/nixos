{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    steam-config-nix.url = "github:different-name/steam-config-nix";
    nix-fs.url = "github:meir/nix-fs";
    quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    qml-niri.url = "github:imiric/qml-niri/main";

    # Overlays
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
    izu.url = "github:meir/izu";
    nh.url = "github:viperML/nh";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    cwal.url = "github:nitinbhat972/cwal";
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
          qml-niri
          cwal
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
