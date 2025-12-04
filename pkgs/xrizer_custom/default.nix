{ xrizer, pkgs, ... }:
xrizer.overrideAttrs rec {
  src = pkgs.fetchFromGitHub {
    owner = "ImSapphire";
    repo = "xrizer";
    rev = "e6927b075f66ba7b12db94402cca35fa4979707c";
    hash = "sha256-h9DsVcwDDfj5P9uPp5fCR/BSWIQg3JntCcQwAWVu+Cw=";
  };

  cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
    inherit src;
    hash = "sha256-tLPwiwKkEBdsRxXgdcTM9TLJeNRZV32W11qUbyCVdHw=";
  };
}

