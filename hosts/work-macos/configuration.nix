{ lib, pkgs, ... }:
{
  user = "meir";
  user_home = "/Users/meir";
  theme.evergreen.enable = true;

  environment.systemPackages = with pkgs; [
    discord
    spotify
  ];

  modules = {
    nvim.enable = true;
    zsh.enable = true;
    yabai.enable = true;
    qutebrowser.enable = true;
    onepassword.enable = true;
    wezterm.enable = true;
  };

  homebrew = {
    enable = true;
  };
}
