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
      gnugrep
      cdl
      starship
      onefetch
      fastfetch
    ];

    hm.programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      history.size = 10000;

      oh-my-zsh = {
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

      initExtra =
        builtins.readFile ../../../config/zsh/shellinit.sh
        + ''
          eval "$(${lib.getExe pkgs.starship} init zsh)"
          source "${pkgs.cdl}/bin/cdl-alias"
        '';
    };

    hm.home.file.".config/starship.toml" = {
      source = ../../../config/zsh/starship.toml;
    };

    # users.defaultUserShell = pkgs.zsh;
    environment.shells = [ pkgs.zsh ];
  };
}
