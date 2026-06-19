{ pkgs, zen-browser, qml-niri, nixpkgs-unstable, cwal, ... }@inputs:
with pkgs;
let
  sys = pkgs.stdenv.hostPlatform.system;
in
final: prev: {
  cozette-nerdfont = callPackage ../pkgs/cozette-nerdfont { };
  dina-remastered = callPackage ../pkgs/dina-remastered { };
  cdl = callPackage ../pkgs/cdl { };
  sm64coopdx-local = callPackage ../pkgs/sm64coopdx { };
  monado_start = callPackage ../pkgs/monado_start { };
  votv = callPackage ../pkgs/votv { };
  pngtuber-plus = callPackage ../pkgs/pngtuber-plus { };
  steam-vdf = pkgs.python3Packages.callPackage ../pkgs/steam-vdf { };
  baballonia-git = callPackage ../pkgs/baballonia { };
  stremio-linux-shell = callPackage ../pkgs/stremio-linux-shell { };
  libsnout = callPackage ../pkgs/libsnout { };

  zen-browser = zen-browser.packages."${sys}".default;
  zen-browser-unwrapped = zen-browser.packages."${sys}".beta-unwrapped;
  qml-niri = qml-niri.packages."${sys}".default;
  cwal = cwal.packages."${sys}".default;

  monado_custom = import ../pkgs/monado inputs;
  xrizer_custom = import ../pkgs/xrizer inputs;

  ndi-6 = prev.ndi-6.overrideAttrs (oldAttrs: {
    src = prev.fetchurl {
      url = "https://downloads.ndi.tv/SDK/NDI_SDK_Linux/${oldAttrs.installerName}.tar.gz";
      hash = "sha256-wLXfFzJIiGJ7ZSF8e4UNdQKHxS4z6WSF4qprESKeYD4=";
    };
  });

  unstable = import nixpkgs-unstable {
    system = final.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
}
