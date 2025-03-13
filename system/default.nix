{
  lib,
  pkgs,
  izu,
  ...
}@inputs:
{
  imports = [
    ./audio.nix
    ./locale.nix
    ./network.nix
    ./nixos.nix
    ./security.nix
    ./user.nix
    ./fonts.nix
    ./protocol.nix
    ./applications.nix
    ./terminal.nix
    ./storage.nix

    # themes
    ../themes/evergreen

    ../modules
  ];

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (import ../overlays/izu.nix inputs)
    (import ../overlays/nixpkgs-unstable.nix inputs)
    (import ../overlays/nixpkgs-xr.nix inputs)
    (import ../overlays/packages.nix inputs)
  ];

  environment.systemPackages = with pkgs; [ curl ];

  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  protocol.hotkeys = [
    ''
      # close app
      super + q
        sxhkd | bspc node -c
        hyprland | killactive

      # kill app
      super + shift + q
        sxhkd | bspc node -k
        hyprland | forcekillactive

      # change mode
      super + {t,shift + t,s,f}
        sxhkd | bspc node -t {tiled,pseudo_tiled,floating,fullscreen}
        hyprland | {settiled,pseudo,setfloating,fullscreen}

      # resize window
      super + mouse_lmb | hyprland[m]
        hyprland | movewindow

      super + mouse_rmb | hyprland[m]
        hyprland | resizewindow

      # set flag
      super + shift + {m,x,y,z}
        sxhkd | bspc node -g {marked,locked,sticky,private}

      # focus/move the node in given direction
      super + {_,shift + }{h,j,k,l}
        sxhkd | bspc node -{f,s} {west,south,north,east}
        hyprland | movefocus, {l,d,u,r}

      # move (node) to desktop
      super + {_,shift + }{1,2,3,4,5,6,7,8,9,0}
        sxhkd | bspc {desktop -f,node -d} {1,2,3,4,5,6,7,8,9,10}
        hyprland | {workspace,movetoworkspace}, {1,2,3,4,5,6,7,8,9,10}

      # reload keybind config
      shift + super + r
        sxhkd | pkill -x sxhkd && sxhkd &
        hyprland | exec, hyprctl reload

      # screenshot region
      super + shift + p
        hyprland | exec, ${lib.getExe pkgs.hyprshot} -m region
    ''
  ];

  system.stateVersion = "24.05";
}
