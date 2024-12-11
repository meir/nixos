{ pkgs, izu, ... }:
final: prev: {
  cozette-nerdfont = import ../pkgs/cozette-nerdfont final;
  dina-remastered = import ../pkgs/dina-remastered final;
  cdl = import ../pkgs/cdl final;
  walld = import ../pkgs/walld final;
  replace = import ../pkgs/replace final;
  izu = import ../pkgs/izu final;
}
