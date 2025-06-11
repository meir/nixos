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

  imports = [
    (mkAliasOptionModule
      [ "hm" ]
      [
        "home-manager"
        "users"
        config.user
      ]
    )
  ];

  config = {
    environment.variables = {
      "XDG_CONFIG_HOME" = "${config.user_home}/.config";
      "XDG_DATA_HOME" = "${config.user_home}/.local/share";
    };

    home-manager = {
      users."${config.user}".home = {
        username = config.user;
        homeDirectory = config.user_home;
        stateVersion = "25.05";
      };

      useUserPackages = true;
      useGlobalPkgs = true;
    };

    users.users."${config.user}" = {
      isNormalUser = true;
      name = config.user;
      home = config.user_home;
      initialPassword = "nixos";
      extraGroups = [
        "networkmanager"
        "wheel"
        "desktop"
        "docker"
      ];
    };
  };
}
