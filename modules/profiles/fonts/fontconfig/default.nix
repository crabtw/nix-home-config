{ pkgs, ... }:

let

  myConf = pkgs.runCommandLocal "my-fontconfig-conf" {} ''
    mkdir -p $out/etc/fonts
    ln -s ${./conf.d} $out/etc/fonts/conf.d
  '';

in

{
  home.packages = with pkgs; [
    myConf

    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra

    opendesktop-fonts
    wqy_microhei
    wqy_unibit
    ipafont
    ipaexfont

    dejavu_fonts
    freefont_ttf
    liberation_ttf

    inconsolata
  ];

  fonts.fontconfig.enable = true;
}
