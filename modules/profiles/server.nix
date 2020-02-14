{ pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  home.packages = with pkgs; [
    haskellPackages.wawabook
  ];

  systemd.user.startServices = true;

  services.today-books = {
    enable = true;
    dates = "19:00:00";
    delay = "30min";
  };

  programs.tmux.extraConfig =  ''
    new  -n irc
    neww -n wawabook -c ~/db/wawabook
    neww -n ats-xanadu -c ~/src/ATS-Xanadu/
    neww -n rust -c ~/src/rust/
    neww -n ocaml -c ~/src/ocaml/
    neww -n idris2 -c ~/src/Idris2/
    neww -n libstdc++ -c ~/src/libstdc++-v3
    neww -n llvm -c ~/src/llvm-project
    neww -n fstar -c ~/src/FStar
    neww -n z3 -c ~/src/z3
    neww -n ghc -c ~/src/ghc
    neww -n cranelift -c ~/src/cranelift
    neww -n compcert -c ~/src/CompCert
    neww -n sail -c ~/src/sail
    neww -n grin -c ~/src/grin

    neww -c ~/
    selectw -t 0
  '';
}
