{ pkgs, zen-browser, ... }:
with pkgs;
final: prev: {
  cozette-nerdfont = callPackage ../pkgs/cozette-nerdfont { };
  dina-remastered = callPackage ../pkgs/dina-remastered { };
  cdl = callPackage ../pkgs/cdl { };
  discord_wayland = import ../pkgs/discord_wayland final;
  sm64coopdx-local = callPackage ../pkgs/sm64coopdx { };
  zen-browser = zen-browser.packages."${final.system}";
  monado_start = callPackage ../pkgs/monado_start { };
  monado_custom = prev.monado.overrideAttrs (old: {
    src = final.fetchFromGitHub {
      owner = "ToasterUwU";
      repo = "monado";
      rev = "8f85280c406ce2e23939c58bc925cf939f36e1e8";
      hash = "sha256-ZeSmnAZ2gDiLTdlVAKQeS3cc6fcRBcSjYZf/M6eI8j4=";
    };

    cmakeFlags = old.cmakeFlags ++ [
      (final.lib.cmakeBool "XRT_HAVE_OPENCV" false)
    ];
  });
  xrizer_custom = pkgs.xrizer.overrideAttrs rec {
    src = pkgs.fetchFromGitHub {
      owner = "RinLovesYou";
      repo = "xrizer";
      rev = "f491eddd0d9839d85dbb773f61bd1096d5b004ef";
      hash = "sha256-12M7rkTMbIwNY56Jc36nC08owVSPOr1eBu0xpJxikdw=";
    };

    cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-87JcULH1tAA487VwKVBmXhYTXCdMoYM3gOQTkM53ehE=";
    };

    patches = [ ];

    doCheck = false;
  };
}
