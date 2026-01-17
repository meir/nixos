{ pkgs, nixpkgs-xr, ... }:
let
  xrizer = nixpkgs-xr.packages."${pkgs.stdenv.hostPlatform.system}".xrizer;
in
xrizer.overrideAttrs {
  src = pkgs.fetchFromGitHub {
    owner = "ImSapphire";
    repo = "xrizer";
    rev = "10c19ca7af26a0fb205e86a83988fbd0861c7b53";
    hash = "sha256-NnNYzoekeZeNQVoy8phcnWkyORFvxizDVkWGArg316g=";
  };

  cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
    inherit (pkgs) src;
    hash = "sha256-orfK5pwWv91hA7Ra3Kk+isFTR+qMHSZ0EYZTVbf0fO0=";
  };
}

