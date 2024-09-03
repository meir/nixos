{ lib, pkgs, ... }:
{
  user = "meir";
  user_home = "/Users/meir";

  modules = {
    nvim.enable = true;
    zsh.enable = true;
    yabai.enable = true;
  };

  homebrew = {
    enable = true;
    casks = [ "qutebrowser" ];
  };

  home-manager.users.meir = {
    programs = {
      wezterm.enable = true;
    };
  };
}
