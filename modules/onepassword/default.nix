{
  config,
  pkgs,
  mkModule,
  ...
}:
mkModule config "onepassword" {
  environment.packages = with pkgs; [ _1password ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "1password-gui"
      "1password"
    ];

  programs._1password.enable = true;
  programs._1password-gui.enable = true;
}
