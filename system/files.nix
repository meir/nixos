{
  config,
  lib,
  ...
}:
with lib;
{
  imports = [
    (
      mkAliasOptionModule
        [ "files" ]
        [
          "home-manager"
          "users"
          config.user
          "home"
          "file"
        ]
    )
  ];

  config = {
    home-manager = {
      users."${config.user}".home = {
        username = config.user;
        homeDirectory = config.home;
        stateVersion = "25.05";
      };

      useUserPackages = false;
      useGlobalPkgs = false;
    };
  };
}
