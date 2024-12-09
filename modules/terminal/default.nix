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
    ${readFile ../../config/kitty/kitty.conf}

    ${readFile config.modules."${name}".config or ""}
  '';
in
{
  options.modules."${name}" = {
    enable = mkEnableOption "kitty terminal emulator";
    config = mkOption {
      type = types.nullOr types.path;
      default = null;
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

    hm.home.file.".config/kitty/kitty.conf" = {
      source = configFile;
    };

    protocol.hotkeys = [
      ''
        super + Return
          kitty
      ''
    ];
  };
}
