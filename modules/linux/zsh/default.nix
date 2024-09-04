{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.modules.zsh.enable = mkEnableOption "zsh";

  config = mkIf config.modules.zsh.enable {
    environment.systemPackages = with pkgs; [
      zsh
      oh-my-zsh
      bash
      gnugrep
      cdl
      starship
      onefetch
    ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;

      histSize = 10000;

      ohMyZsh = {
        enable = true;
        plugins = [
          "git"
          "docker"
          "golang"
          "kubectl"
        ];
      };

      shellAliases = {
        cdd = "cd ~/Documents";
        bye = "exit";
        clear = "clear && printf '\\e[3J'";
        c = "clear";
      };

      shellInit =
        builtins.readFile ../../../config/zsh/shellinit.sh
        + ''
          eval "$(starship init zsh)"
          source "${pkgs.cdl}/bin/cdl-alias"
        '';
    };

    hm.home.file.".config/starship.toml" = {
      source = ../../../config/zsh/starship.toml;
    };

    users.defaultUserShell = pkgs.zsh;
    environment.shells = [ pkgs.zsh ];
  };
}
