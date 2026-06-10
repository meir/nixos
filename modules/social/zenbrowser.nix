{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = with pkgs; (wrapFirefox zen-browser-unwrapped { });
  };

  xdg.mime.defaultApplications = {
    "text/html" = "zenbrowser.desktop";
    "x-scheme-handler/http" = "zenbrowser.desktop";
    "x-scheme-handler/https" = "zenbrowser.desktop";
  };
}
