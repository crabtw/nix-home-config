{ pkgs, ... }:

{
  home.packages = [ pkgs.nix-direnv ];

  programs.direnv = {
    enable = true;
    stdlib = ''
      source ${pkgs.nix-direnv}/share/nix-direnv/direnvrc
    '';
  };
}
