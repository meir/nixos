{ lib, pkgs, ... }:
{
  user = "meir";
  user_home = "/Users/meir";
  theme.evergreen.enable = true;

  environment.systemPackages = with pkgs; [
    discord
    spotify
    comma
    gnused
    gnupg
    direnv
    izu
  ];

  modules = {
    nvim.enable = true;
    zsh.enable = true;
    aerospace.enable = true;
    qutebrowser.enable = true;
    onepassword.enable = true;
    wezterm.enable = true;
  };

  homebrew = {
    enable = true;
    casks = [ "vial" ];
  };
}
