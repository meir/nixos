{
  pkgs,
  ...
}:
{
  config = {
    stylix = {
      enable = true;

      fonts = with pkgs; {
        serif = dina-remastered;
        sansSerif = dina-remastered;
        emoji = dina-remastered;
      };
    };
  };
}
