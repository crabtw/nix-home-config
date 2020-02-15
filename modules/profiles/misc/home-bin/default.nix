{ pkgs, ... }:

{
  home.sessionVariables.PATH = "$HOME/bin:$PATH";

  home.file."bin/dmenu_run".source = pkgs.runCommandLocal "home-bin-dmenu_run.sh" {} ''
    install -m755 ${./dmenu_run.sh} $out

    substituteInPlace $out \
      --subst-var-by runtimeShell "${pkgs.runtimeShell}" \
      --subst-var-by util-linux "${pkgs.utillinux}" \
      --subst-var-by dmenu "${pkgs.dmenu}"
  '';

  home.file."bin/feh_rifle".source = pkgs.runCommandLocal "home-bin-feh_rifle.rb" {} ''
    install -m755 ${./feh_rifle.rb} $out

    substituteInPlace $out \
      --subst-var-by ruby "${pkgs.ruby}" \
      --subst-var-by feh "${pkgs.feh}"
  '';

  home.file."bin/seq-rename".source = pkgs.runCommandLocal "home-bin-seq-rename.rb" {} ''
    install -m755 ${./seq-rename.rb} $out

    substituteInPlace $out \
      --subst-var-by ruby "${pkgs.ruby}"
  '';

  home.file."bin/chperm".source = pkgs.runCommandLocal "home-bin-chperm.rb" {} ''
    install -m755 ${./chperm.rb} $out

    substituteInPlace $out \
      --subst-var-by ruby "${pkgs.ruby}"
  '';

  home.file."bin/comicdb".source =
    let
      ruby = pkgs.ruby.withPackages (pkgs: [ pkgs.sqlite3 ]);
    in
      pkgs.runCommandLocal "home-bin-comicdb.rb" {} ''
        install -m755 ${./comicdb.rb} $out

        substituteInPlace $out \
          --subst-var-by ruby "${ruby}"
      '';

  home.file."bin/comicdb-sh" = {
    executable = true;
    text = ''
      #!${pkgs.runtimeShell}
      
      while true; do
          printf ">> "
          if read x; then
              true
          else
              exit
          fi
      
          x=`echo $x | sed -r 's/^\s+|\s+$//'`
      
          if [[ -z "$x" ]]; then
              continue
          fi
      
          comicdb "$x"
      done
    '';
  };
}
