{ pkgs, nixpkgs-xr, lib, ... }:
let
  monado = nixpkgs-xr.packages."${pkgs.stdenv.hostPlatform.system}".monado;
in
monado.overrideAttrs {
  cmakeFlags = monado.cmakeFlags ++ [
    (lib.cmakeBool "XRT_FEATURE_OPENXR_VISIBILITY_MASK" false)
  ];
}
