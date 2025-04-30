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

      iconv
    ];

    programs.zsh.enable = true;
    hm.programs.zsh = {
      enable = true;
      package = pkgs.zsh;
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

      initExtra = ''
        # init all completions
        autoload -U compinit && compinit
        compinit

        HIST_STAMPS="yyyy/mm/dd"

        [ -d ".git" ] && onefetch || fastfetch
        eval "$(${lib.getExe pkgs.direnv} hook zsh)"
        eval "$(${lib.getExe pkgs.starship} init zsh)"
        source "${pkgs.cdl}/bin/cdl-alias"
      '';
    };

    hm.home.file = {
      ".cache/oh-my-zsh/completions/_cdl".source = "${pkgs.cdl}/shared/.oh-my-zsh/completions/_cdl";
      ".config/starship.toml".source = ./starship.toml;
    };
  };
}
