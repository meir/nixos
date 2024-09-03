{ lib, pkgs, ... }:
{
  user = "meir";
  user_home = "/Users/meir";

  modules = {
    nvim.enable = true;
    zsh.enable = true;
  };

  home-manager.users.meir = {

  };
}
