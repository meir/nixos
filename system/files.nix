{
  config,
  ...
}:
{
  config = {
    nix-fs.home = config.home;
  };
}
