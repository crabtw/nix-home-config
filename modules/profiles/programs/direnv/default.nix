{ config, ... }:

let

  nix-direnv = import ./nix-direnv.nix;

in

{
  programs.direnv.enable = true;

  xdg.configFile."direnv/direnvrc".text = ''
    source ${nix-direnv}/direnvrc
  '';
}
