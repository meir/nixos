{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    steam-config-nix.url = "github:different-name/steam-config-nix";
    nix-fs.url = "github:meir/nix-fs";
    snoutlink.url = "github:meir/snoutlink";
    qml-niri.url = "github:imiric/qml-niri/main";

    # Overlays
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
    nh.url = "github:viperML/nh";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    cwal.url = "github:nitinbhat972/cwal";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    milk-grub.url = "github:gemakfy/MilkGrub";
  };

  outputs =
    inputs:
    let
      specialArgs = {
        modules = import ./lib/modules.nix;
        inherit (inputs)
          nixpkgs-unstable
          nixpkgs-xr
          nh
          zen-browser
          steam-config-nix
          nix-fs
          snoutlink
          quickshell
          qml-niri
          cwal
          spicetify-nix
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
