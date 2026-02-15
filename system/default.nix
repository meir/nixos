{
  lib,
  pkgs,
  ...
}@inputs:
{
  imports = [
    ./files.nix
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
    ./style.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (import ../overlays/packages.nix inputs)
  ];

  nix-fs.files.".icons/default".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic";

  environment.systemPackages = with pkgs; [
    curl
    git-credential-manager
    pass
    gcc
    libgcc
    opencl-headers
    ocl-icd
  ];

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
        niri | close-window;

      # kill app
      super + shift + q
        sxhkd | bspc node -k
        hyprland | forcekillactive
        niri | spawn "xkill";

      # change mode
      super + {t,s,f}
        sxhkd | bspc node -t {tiled,floating,fullscreen}
        hyprland | {settiled,setfloating,fullscreen}
        niri | {reset-window-height,toggle-window-floating,fullscreen-window};

      # resize window
      super + mouse_lmb | hyprland[m]
        hyprland | movewindow
        niri | spawn "echo not supported";

      super + mouse_rmb | hyprland[m]
        hyprland | resizewindow
        niri | spawn "echo not supported";

      # focus/move the node in given direction
      super + {_,shift + }{h,j,k,l}
        sxhkd | bspc node -{f,s} {west,south,north,east}
        hyprland | movefocus, {l,d,u,r}
        niri | {move-column-left,move-window-down,move-window-up,move-column-right};

      # move (node) to desktop
      super + {_,shift + }{1,2,3,4,5,6,7,8,9,0}
        sxhkd | bspc {desktop -f,node -d} {1,2,3,4,5,6,7,8,9,10}
        hyprland | {workspace,movetoworkspace}, {1,2,3,4,5,6,7,8,9,10}
        niri | {focus-workspace,move-column-to-workspace} {1,2,3,4,5,6,7,8,9,10};

      # reload keybind config
      shift + super + r
        sxhkd | pkill -x sxhkd && sxhkd &
        hyprland | exec, hyprctl reload
        niri | spawn "niri validate";

      # screenshot region
      super + shift + p
        hyprland | exec, ${lib.getExe pkgs.hyprshot} -m region --clipboard-only
        niri | screenshot;
    ''
  ];

  system.stateVersion = "24.05";
}
