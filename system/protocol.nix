{
  lib,
  ...
}:
with lib;
{
  options.protocol = {
    hotkeys = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };

    autostart = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };
}
