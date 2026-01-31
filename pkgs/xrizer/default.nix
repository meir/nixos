{ pkgs, nixpkgs-xr, ... }:
let
  xrizer = nixpkgs-xr.packages."${pkgs.stdenv.hostPlatform.system}".xrizer;
in
xrizer.overrideAttrs rec {
  src = pkgs.fetchFromGitHub {
    owner = "ImSapphire";
    repo = "xrizer";
    rev = "c87d7c38fbc372980ca226802a524c1d6d85403e";
    hash = "sha256-PEypy9lOcL8Nbc11YYgXNhkoBEyJVStVGs+tozcumeY=";
  };

  cargoDeps = pkgs.rustPlatform.importCargoLock {
    lockFile = src + "/Cargo.lock";
    outputHashes = {
      "openxr-0.19.0" = "sha256-mljVBbQTq/k7zd/WcE1Sd3gibaJiZ+t7td964clWHd8=";
    };
  };
}

