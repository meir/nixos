{
  # compositor
  hyprland = ./modules/compositor/hyprland.nix;
  niri = ./modules/compositor/niri.nix;

  # desktop
  eww = ./modules/desktop/eww.nix;
  mako = ./modules/desktop/mako.nix;
  nautilus = ./modules/desktop/nautilus.nix;
  rofi = ./modules/desktop/rofi.nix;
  swww = ./modules/desktop/swww.nix;
  
  # games
  steam = ./modules/games/steam.nix;
  steamvr = ./modules/games/steamvr.nix;
  monado = ./modules/games/monado.nix;

  # hardware
  amdgpu = ./modules/hardware/amdgpu.nix;

  # social
  discord = ./modules/social/discord.nix;
  mprisence = ./modules/social/mprisence.nix;
  qutebrowser = ./modules/social/qutebrowser.nix;
  zenbrowser = ./modules/social/zenbrowser.nix;

  # terminal
  neovim = ./modules/terminal/neovim.nix;

  # utility
  bluetooth = ./modules/utility/bluetooth.nix;
  onepassword = ./modules/utility/onepassword.nix;
  qmk = ./modules/utility/qmk.nix;

  # virtualization
  docker = ./modules/virtualization/docker.nix;
}
