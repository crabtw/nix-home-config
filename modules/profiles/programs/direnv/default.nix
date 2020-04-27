{ pkgs, ... }:

let

  nix-direnv = import ./nix-direnv.nix { inherit pkgs; };

in

{
  programs.direnv.enable = true;

  xdg.configFile."direnv/direnvrc".text = ''
    source ${nix-direnv}/share/nix-direnv/direnvrc
  '';
}
