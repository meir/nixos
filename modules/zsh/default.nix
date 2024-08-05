{
  config,
  pkgs,
  mkModule,
  ...
}:
mkModule config "zsh" {
  environment.packages = with pkgs; [
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
      builtins.readFile ./shellinit.sh
      + ''
        eval "$(starship init zsh)"
        source "${pkgs.cdl}/bin/cdl-alias"
      '';
  };

  environment.file.starship = {
    source = ./starship.toml;
    target = ".config/starship.toml";
  };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = [ pkgs.zsh ];
}
