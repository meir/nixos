{ config, options, pkgs, lib, ... }:
with lib;
{ 
  options = {
    user = mkOption {
      type = types.str;
      default = "human";
      description = "Name of the default user";
    };
    user_home = mkOption {
      type = types.path;
      default = "/home/${config.user}/";
      internal = true;
      description = "Home directory of the default user";
    };
  };
}
