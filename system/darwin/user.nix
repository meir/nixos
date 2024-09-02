{ config, pkgs, ... }:
{
  users.users.${config.my.user} = {
    home = "/Users/${config.my.user}";
    shell = pkgs.zsh;
  };
}
