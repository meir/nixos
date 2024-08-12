{ config, lib, ... }: with lib; { programs.sway.enable = config.protocol.wayland.enable; }
