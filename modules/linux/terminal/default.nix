{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  name = "kitty";

  configFile = pkgs.writeScript "kitty-config" ''
    ${readFile ./kitty.conf}

    ${readFile config.modules."${name}".config}
  '';
in
{
  options.modules."${name}" = {
    enable = mkEnableOption "kitty terminal emulator";
    config = mkOption {
      type = types.path;
      default = ./kitty.conf;
    };
  };

  config = mkIf config.modules."${name}".enable {
    environment.systemPackages = with pkgs; [
      kitty

      # terminal tools
      btop
      nvtopPackages.full
      fastfetch
      xdotool
      cargo
      rustc
    ];

    programs = {
      gnupg.agent.enable = true;
      direnv.enable = true;
    };

    environment.file.kitty = {
      source = configFile;
      target = ".config/kitty/kitty.conf";
    };

    protocol.hotkeys = {
      "super + Return" = "kitty";
    };
  };
}
