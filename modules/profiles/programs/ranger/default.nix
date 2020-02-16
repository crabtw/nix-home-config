{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ranger
    atool
  ];

  xdg.configFile."ranger/commands.py".source = pkgs.runCommandLocal "ranger-config-command.py" {} ''
    install -m644 ${./commands.py} $out

    substituteInPlace $out \
      --subst-var-by atool "${pkgs.atool}" \
      --subst-var-by ffmpeg "${pkgs.ffmpeg}" \
      --subst-var-by mplayer "${pkgs.mplayer}"
  '';

  xdg.configFile."ranger/rifle.conf".source = pkgs.runCommandLocal "ranger-config-rifle.conf" {} ''
    install -m644 ${pkgs.ranger}/share/doc/ranger/config/rifle.conf $out

    sed -E -i \
      -e '/^mime[ ]+\^image,[ ]+has[ ]+feh,/ { s/feh( --)?/feh_rifle/g }' \
      -e 's/"\$PAGER"/\$PAGER/g' \
      $out
  '';

  xdg.configFile."ranger/rc.conf".text = ''
    set preview_images false
    set preview_files false
  '';
}
