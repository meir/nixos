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
    spaceship-prompt
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
      ''
        source "${pkgs.spaceship-prompt}/lib/spaceship-prompt/spaceship.zsh"
        source "${pkgs.cdl}/bin/cdl-alias"
      ''
      + builtins.readFile ./shellinit.sh;
  };

  environment.file.spaceshiprc = {
    source = ./spaceshiprc.zsh;
    target = ".spaceshiprc.zsh";
  };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = [ pkgs.zsh ];
}
