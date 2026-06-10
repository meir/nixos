{ pkgs, lib, profile ? null, ... }:
with lib;
let
  fx-autoconfig = pkgs.fetchFromGitHub {
    owner = "MrOtherGuy";
    repo = "fx-autoconfig";
    rev = "master";
    sha256 = "sha256-czNgt62fofg3hXw7F4wXSv/+ZAsGtO6bg3sUOiUXcu4=";
  };
in
{
  programs.firefox = {
    enable = true;
    package = with pkgs; (wrapFirefox (zen-browser-unwrapped.overrideAttrs {
      postInstall = ''
        for libdir in "$out"/lib/zen-bin-*; do
          chmod -R u+w "$libdir"
          cp "${fx-autoconfig}/program/config.js" "$libdir/config.js"
          mkdir -p "$libdir/default/pref"
          cp "${fx-autoconfig}/program/defaults/pref/config-prefs.js" "$libdir/defaults/pref/config-pref.js"
        done
      '';
    }) {});
  };

  xdg.mime.defaultApplications = {
    "text/html" = "zenbrowser.desktop";
    "x-scheme-handler/http" = "zenbrowser.desktop";
    "x-scheme-handler/https" = "zenbrowser.desktop";
  };

  nix-fs.files = mkIf (profile != null) {
    ".zen/${profile}.Default Profile/chrome/utils".source = "${fx-autoconfig}/profile/chrome/utils";
    ".zen/${profile}.Default Profile/chrome/JS".source = ../../config/zen/JS;
  };
}
