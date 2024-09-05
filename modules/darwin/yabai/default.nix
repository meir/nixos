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
    environment.systemPackages = with pkgs; [ jq ];

    services = {
      yabai = {
        enable = true;
        config = {
          layout = "bsp";
          mouse_modifier = "cmd";
          mouse_action1 = "move";
          mouse_action2 = "resize";
          mouse_drop_action = "swap";
          top_padding = "20";
          bottom_padding = "20";
          left_padding = "20";
          right_padding = "20";
          window_gap = "10";
        };
      };
      jankyborders = {
        enable = true;
        width = 8.0;
        style = "round";
        active_color = "0xFFD1496B";
        inactive_color = "0xFF10A070";
        hidpi = true;
      };
    };
  };
}
