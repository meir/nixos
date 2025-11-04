{ pkgs, zen-browser, ... }:
with pkgs;
final: prev: {
  cozette-nerdfont = callPackage ../pkgs/cozette-nerdfont { };
  dina-remastered = callPackage ../pkgs/dina-remastered { };
  cdl = callPackage ../pkgs/cdl { };
  discord_wayland = import ../pkgs/discord_wayland final;
  sm64coopdx-local = callPackage ../pkgs/sm64coopdx { };
  zen-browser = zen-browser.packages."${final.system}";
  monado = monado.overrideAttrs (old: {
    src = fetchFromGitLab {
      domain = "gitlab.freedesktop.org";
      owner = "Supreeeme";
      repo = "monado";
      rev = "e57d5411f53ab72e715b4ce91d26ff96c80ac711";
      hash = "sha256-VxTxvw+ftqlh3qF5qWxpK1OJsRowkRXu0xEH2bDckUA=";
    };
  });
}
