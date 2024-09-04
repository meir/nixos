{ lib, pkgs, ... }:
{
  user = "meir";
  user_home = "/Users/meir";

  environment.systemPackages = with pkgs; [
    discord
    spotify
  ];

  modules = {
    nvim.enable = true;
    zsh.enable = true;
    yabai.enable = true;
    qutebrowser.enable = true;
  };

  home-manager.users.meir = {
    programs = {
      wezterm.enable = true;
    };
  };
}
