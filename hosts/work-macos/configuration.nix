{ lib, pkgs, ... }:
{
  user = "meir";
  user_home = "/Users/meir";

  home-manager.users.meir = {
    home = {
      username = "meir";
      homeDirectory = "/Users/meir";
    };
  };
}
