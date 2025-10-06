{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  options.modules.nvim.enable = mkEnableOption "nvim";

  config = mkIf config.modules.nvim.enable {
    environment.systemPackages = with pkgs; [
      neovim
      gcc
      iconv
      xcode-install
      git
      curl
      cmake
      go
      gnumake
      nodejs_22
      fzf
      rustup
      ripgrep
      xclip
      nixfmt-rfc-style
      luajitPackages.luarocks
      lua51Packages.lua
      tree-sitter
      fd
      coreutils

      # conform
      black
      clang-tools
      gotools
      google-java-format
      ktlint
      nodePackages.prettier
      rufo
      shfmt
      stylua
    ];
  };
}
