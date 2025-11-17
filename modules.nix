{
  eww = ./modules/desktop/eww.nix;
  mako = ./modules/desktop/mako.nix;
  nautilus = ./modules/desktop/nautilus.nix;
  rofi = ./modules/desktop/rofi.nix;
  swww = ./modules/desktop/swww.nix;
  
  steam = ./modules/games/steam.nix;
  steamvr = ./modules/games/steamvr.nix;
  monado = ./modules/games/monado.nix;

  amdgpu = ./modules/hardware/amdgpu.nix;

  discord = ./modules/social/discord.nix;
  mprisence = ./modules/social/mprisence.nix;
  qutebrowser = ./modules/social/qutebrowser.nix;
  zenbrowser = ./modules/social/zenbrowser.nix;

  neovim = ./modules/terminal/neovim.nix;

  bluetooth = ./modules/utility/bluetooth.nix;
  onepassword = ./modules/utility/onepassword.nix;
  qmk = ./modules/utility/qmk.nix;

  docker = ./modules/virtualization/docker.nix;
}
