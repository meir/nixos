{ ... }:
{
  protocol.hotkeys = [
    ''
      Print
        hyprland | exec, ${lib.getExe pkgs.flameshot} gui
        ${lib.getExe pkgs.flameshot} gui

      # paste
      super + v
        hyprland | exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy

      # close app
      super + q
        sxhkd | bspc node -c
        hyprland | killactive

      # kill app
      super + shift + q
        sxhkd | bspc node -k
        hyprland | exec, hyprctl activewindow -j | jq -r '.pid' | xargs kill

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
    ''
  ];
}
