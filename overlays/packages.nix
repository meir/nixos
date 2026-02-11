{ pkgs, zen-browser, izu, quickshell, niri, nix-gaming, nixpkgs-unstable, nixpkgs-xr, ... }@inputs:
with pkgs;
let
  system = pkgs.stdenv.hostPlatform.system;
in
final: prev: {
  cozette-nerdfont = callPackage ../pkgs/cozette-nerdfont { };
  dina-remastered = callPackage ../pkgs/dina-remastered { };
  cdl = callPackage ../pkgs/cdl { };
  sm64coopdx-local = callPackage ../pkgs/sm64coopdx { };
  monado_start = callPackage ../pkgs/monado_start { };
  votv = callPackage ../pkgs/votv { };
  steam-vdf = pkgs.python3Packages.callPackage ../pkgs/steam-vdf { };
  baballonia-git = callPackage ../pkgs/baballonia { };
  stremio-linux-shell = callPackage ../pkgs/stremio-linux-shell { };

  izu = izu.packages."${system}";
  zen-browser = zen-browser.packages."${system}".default;
  quickshell = quickshell.packages."${system}".default;
  niri = niri.packages."${system}".niri;
  rocket-league = nix-gaming.packages."${system}".rocket-league;

  monado_custom = import ../pkgs/monado inputs;
  xrizer_custom = import ../pkgs/xrizer inputs;

  unstable = import nixpkgs-unstable (final // { 
    config.allowUnfree = true;
  });
}
