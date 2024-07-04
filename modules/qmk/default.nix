{
  config,
  pkgs,
  mkModule,
  ...
}:
mkModule config "qmk" {
  environment.packages = with pkgs; [
    udev
    vial
    qmk
  ];

  services.udev.packages = with pkgs; [ vial ];
}
