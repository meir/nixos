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
        enableScriptingAddition = true;
        extraConfig = ''
          yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
          yabai -m signal --add event=space_changed action="pkill -x borders"
          launchctl unload -F /System/Library/LaunchAgents/com.apple.WindowManager.plist > /dev/null 2>&1 &

        '';
      };
      jankyborders = {
        enable = true;
        width = 8.0;
        style = "round";
        active_color = "0xFFD1496B";
        inactive_color = "0xFF10A070";
        hidpi = true;
      };
      skhd = {
        enable = true;
        skhdConfig = ''
          cmd - return : ${pkgs.wezterm}
          cmd - 1 : yabai -m space --focus 1
          cmd - 2 : yabai -m space --focus 2
          cmd - 3 : yabai -m space --focus 3
          cmd - 4 : yabai -m space --focus 4
          cmd - 5 : yabai -m space --focus 5
          cmd - 6 : yabai -m space --focus 6
          cmd - 7 : yabai -m space --focus 7
          cmd - 8 : yabai -m space --focus 8
          cmd - 9 : yabai -m space --focus 9
          cmd - 0 : yabai -m space --focus 10
          cmd + shift - 1 : yabai -m window --space 1
          cmd + shift - 2 : yabai -m window --space 2
          cmd + shift - 3 : yabai -m window --space 3
          cmd + shift - 4 : yabai -m window --space 4
          cmd + shift - 5 : yabai -m window --space 5
          cmd + shift - 6 : yabai -m window --space 6
          cmd + shift - 7 : yabai -m window --space 7
          cmd + shift - 8 : yabai -m window --space 8
          cmd + shift - 9 : yabai -m window --space 9
          cmd + shift - 0 : yabai -m window --space 10
          cmd - h : yabai -m window --focus west
          cmd - j : yabai -m window --focus south
          cmd - k : yabai -m window --focus north
          cmd - l : yabai -m window --focus east
        '';
      };
    };
  };
}
