{
  options,
  config,
  pkgs,
  lib,
  ...
}:
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
      default = "/home/${config.user}";
      internal = true;
      description = "Home directory of the default user";
    };
  };

  config = {
    environment.variables = {
      "XDG_CONFIG_HOME" = "${config.user_home}/.config";
      "XDG_DATA_HOME" = "${config.user_home}/.local/share";
    };

    users.users."${config.user}" = {
      home = config.user_home;
    };

    home-manager.users."${config.user}".home = {
      username = config.user;
      homeDirectory = config.user_home;
    };
  };
}
