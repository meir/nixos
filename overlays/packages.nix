{ pkgs, zen-browser, ... }:
with pkgs;
final: prev: {
  cozette-nerdfont = callPackage ../pkgs/cozette-nerdfont { };
  dina-remastered = callPackage ../pkgs/dina-remastered { };
  cdl = callPackage ../pkgs/cdl { };
  discord_wayland = import ../pkgs/discord_wayland final;
  sm64coopdx-local = callPackage ../pkgs/sm64coopdx { };
  zen-browser = zen-browser.packages."${final.system}";
}
