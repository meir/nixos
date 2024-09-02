{ lib, pkgs, ... }:
{
  home-manager.users.meir = {
    home = {
      username = "meir";
      homeDirectory = "/Users/meir";
    };
  };
}
