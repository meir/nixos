{ config, options, pkgs, lib, ... }:
with lib;
let
  nvimfiles = fetchFromGitHub {
    owner = "meir";
    repo = ".nvim";
    rev = "main";
  };
in {
  options.nvim.enable = mkOption {
    type = types.bool;
    default = true;
    description = "Enable nvim with dotfiles";
  };

  config = mkIf config.nvim.enable {
    modules.packages = [
      neovim
      git
      curl
      gcc
      cmake
      gnumake
      nodejs_18
      fzf
      rustup
      ripgrep
      xclip
      nixfmt
    ];

    environment.file.nvim_config = {
      source = nvimfiles;
      target = "./config/nvim";
    };
  };
}
