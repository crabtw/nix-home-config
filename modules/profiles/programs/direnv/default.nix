{ pkgs, ... }:

{
  home.packages = [ pkgs.nix-direnv ];

  programs.direnv.enable = true;

  xdg.configFile."direnv/direnvrc".text = ''
    source ${pkgs.nix-direnv}/share/nix-direnv/direnvrc
  '';
}
