{
  options,
  lib,
  config,
  ...
}:
with lib;
{
  imports = [
    ./xorg/default.nix
    ./wayland/default.nix
  ];

  options.protocol = {
    xorg.enable = mkOption {
      type = types.bool;
      default = config.protocol.type == "xorg";
    };

    wayland.enable = mkOption {
      type = types.bool;
      default = config.protocol.type == "wayland";
    };

    type = mkOption {
      type = types.enum [
        "xorg"
        "wayland"
      ];
      default = "xorg";
    };

    hotkeys = mkOption {
      type = types.attrsOf types.str;
      default = { };
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
