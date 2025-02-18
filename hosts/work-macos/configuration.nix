{ lib, pkgs, ... }:
{
  user = "meir";
  user_home = "/Users/meir";

  environment.systemPackages = with pkgs; [
    spotify
    comma
    gnused
    gnupg
    direnv
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
