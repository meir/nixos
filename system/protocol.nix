{
  options,
  lib,
  config,
  pkgs,
  ...
}:
with lib;
{
  imports = [
    ./wayland/default.nix
  ];

  options.protocol = {
    wayland.enable = mkOption {
      type = types.bool;
      default = config.protocol.type == "wayland";
    };

    type = mkOption {
      type = types.enum [
        "wayland"
      ];
      default = "wayland";
    };

    hotkeys = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };

    rules = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };

    autostart = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };
}
