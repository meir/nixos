{
  config,
  pkgs,
  mkModule,
  ...
}:
mkModule config "nvim" {
  environment.packages = with pkgs; [
    neovim
    git
    curl
    gcc
    cmake
    go
    gnumake
    nodejs_18
    fzf
    rustup
    ripgrep
    xclip
    nixfmt-rfc-style
  ];
}
