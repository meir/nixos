{ pkgs, izu, ... }:
with pkgs;
final: prev: {
  cozette-nerdfont = callPackage ../pkgs/cozette-nerdfont final;
  dina-remastered = callPackage ../pkgs/dina-remastered final;
  cdl = callPackage ../pkgs/cdl final;
  walld = callPackage ../pkgs/walld final;
  replace = callPackage ../pkgs/replace final;
  izu = callPackage ../pkgs/izu final;
}
