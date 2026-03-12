{ pkgs, nixpkgs-xr, ... }:
let
  xrizer = nixpkgs-xr.packages."${pkgs.stdenv.hostPlatform.system}".xrizer;
in
xrizer.overrideAttrs rec {
  src = pkgs.fetchFromGitHub {
    owner = "ImSapphire";
    repo = "xrizer";
    rev = "f65c872ef9f8108b2d8a28274dcc79b87f5490ec";
    hash = "sha256-CjSJjKt2GD4us5CIcJpqfI/2cxVPQ26T1yzQwC2xwGk=";
  };

  cargoDeps = pkgs.rustPlatform.importCargoLock {
    lockFile = src + "/Cargo.lock";
    outputHashes = {
      "openxr-0.19.0" = "sha256-mljVBbQTq/k7zd/WcE1Sd3gibaJiZ+t7td964clWHd8=";
    };
  };
}

