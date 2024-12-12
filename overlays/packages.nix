{ pkgs, izu, ... }:
with pkgs;
final: prev: {
  cozette-nerdfont = callPackage ../pkgs/cozette-nerdfont { };
  dina-remastered = callPackage ../pkgs/dina-remastered { };
  cdl = callPackage ../pkgs/cdl { };
  walld = callPackage ../pkgs/walld { };
  replace = callPackage ../pkgs/replace { };
  izu = callPackage izu { };
}
