{ pkgs, ... }:

let

  myConf = pkgs.runCommandLocal "my-fontconfig-conf" {} ''
    mkdir -p $out/etc/fonts/conf.d
    ln -s ${./10-my-rendering.conf} $out/etc/fonts/conf.d/10-my-rendering.conf
    ln -s ${./52-my-default-fonts.conf} $out/etc/fonts/conf.d/52-my-default-fonts.conf
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

    inconsolata
    dejavu_fonts
    freefont_ttf
    liberation_ttf
  ];

  fonts.fontconfig.enable = true;
}
