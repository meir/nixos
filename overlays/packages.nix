{ pkgs, zen-browser, izu, steam-config-nix, quickshell, niri, nix-gaming, nixpkgs-unstable, ... }:
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

  izu = izu.packages."${system}";
  zen-browser = zen-browser.packages."${system}".default;
  quickshell = quickshell.packages."${system}".default;
  steam-config-patcher = steam-config-nix.packages."${system}".steam-config-patcher;
  niri = niri.packages."${system}".niri;
  rocket-league = nix-gaming.packages."${system}".rocket-league;

  discord_wayland = import ../pkgs/discord_wayland final;
  monado_custom = import ../pkgs/monado_custom final;
  xrizer_custom = import ../pkgs/xrizer_custom final;
  baballonia-git = import ../pkgs/baballonia final;

  unstable = import nixpkgs-unstable (final // { config.allowUnfree = true; });
}
