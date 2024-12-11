{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
{
  options.system.izu = {
    formatter = mkOption {
      type = types.str;
      default = "sxhkd";
    };
    hotkeys = mkOption {
      type = types.str;
      default = "";
    };
  };

  config = {
    system.izu.hotkeys =
      with pkgs;
      readFile "${
        (izu.override {
          inherit hotkeys;
          formatter = config.system.izu.formatter;
        })
      }";
  };
}
