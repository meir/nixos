{
  config,
  pkgs,
  mkModule,
  ...
}:
mkModule config "nvim" {
  environment.packages = with pkgs; [
    unstable.neovim
    git
    curl
    gcc12
    cmake
    go
    gnumake
    nodejs_18
    fzf
    rustup
    ripgrep
    xclip
    nixfmt-rfc-style
    luajitPackages.luarocks
    lua
  ];
}
