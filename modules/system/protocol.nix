{ options, lib, ... }:
with lib;
{
  imports = [
    ./xorg/default.nix
    ./wayland/default.nix
  ];

  options.protocol = {
    xorg.enable = mkOption {
      type = types.bool;
      default = false;
    };

    wayland.enable = mkOption {
      type = types.bool;
      default = false;
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
