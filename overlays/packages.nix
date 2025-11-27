{ pkgs, zen-browser, izu, quickshell, nixpkgs-unstable, ... }:
with pkgs;
final: prev: {
  cozette-nerdfont = callPackage ../pkgs/cozette-nerdfont { };
  dina-remastered = callPackage ../pkgs/dina-remastered { };
  cdl = callPackage ../pkgs/cdl { };
  sm64coopdx-local = callPackage ../pkgs/sm64coopdx { };
  monado_start = callPackage ../pkgs/monado_start { };
  votv = callPackage ../pkgs/votv { };
  steam-vdf = pkgs.python3Packages.callPackage ../pkgs/steam-vdf { };

  izu = izu.packages."${final.system}";
  zen-browser = zen-browser.packages."${final.system}".default;
  quickshell = quickshell.packages."${final.system}".default;

  discord_wayland = import ../pkgs/discord_wayland final;
  monado_custom = import ../pkgs/monado_custom final;
  xrizer_custom = import ../pkgs/xrizer_custom final;

  unstable = import nixpkgs-unstable (final // { config.allowUnfree = true; });
}
