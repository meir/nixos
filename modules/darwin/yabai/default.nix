{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.modules.yabai.enable = mkEnableOption "yabai";

  config = mkIf config.modules.yabai.enable {
    services.yabai = {
      enable = true;
      config = {
        layout = "bsp";
        mouse_modifier = "cmd";
        mouse_action1 = "move";
        mouse_action2 = "resize";
        mouse_drop_action = "swap";
      };
    };
  };
}
