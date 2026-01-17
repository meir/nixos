{ pkgs, nixpkgs-xr, ... }:
let
  monado = nixpkgs-xr.packages."${pkgs.stdenv.hostPlatform.system}".monado;
in
monado.overrideAttrs {
  cmakeFlags = monado.cmakeFlags ++ [
    "-DXRT_FEATURE_OPENXR_VISIBILITY_MASK=OFF"
  ];
}
