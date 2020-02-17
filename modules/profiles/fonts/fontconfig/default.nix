{ pkgs, ... }:

let

  myConf = pkgs.runCommandLocal "my-fontconfig-conf" {} ''
    mkdir -p $out/etc/fonts/conf.d
    ln -s ${./10-scale-bitmap-fonts.conf} $out/etc/fonts/conf.d/10-scale-bitmap-fonts.conf
    ln -s ${./66-noto-fonts.conf} $out/etc/fonts/conf.d/66-noto-fonts.conf
    ln -s ${./69-wqy-unibit.conf} $out/etc/fonts/conf.d/69-wqy-unibit.conf
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
