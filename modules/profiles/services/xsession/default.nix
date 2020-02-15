{ pkgs, ... }:

{
  home.packages = with pkgs; [
    haskellPackages.xmobar
  ];

  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ./xmonad.hs;
  };

  home.file.".xmobarrc".text = ''
    Config {
        font = "xft:Unibit",
        bgColor = "black",
        fgColor = "grey",
        position = TopW L 90,
        lowerOnStart = True,
        commands = [
            Run Date "%Y-%m-%d, %H:%M" "date" 300,
            Run StdinReader
        ],
        sepChar = "%",
        alignSep = "}{",
        template = "%StdinReader% }{ <fc=#FFA500>%date%</fc>"
    }
  '';

  home.file.".xinitrc".text = ''
    export LANG="zh_TW.UTF-8"
    export LC_ALL="zh_TW.UTF-8"

    export XMODIFIERS="@im=fcitx"
    export GTK_IM_MODULE="fcitx"
    export QT_IM_MODULE="fcitx"
    fcitx -d -r

    # common
    ${pkgs.xorg.xrdb}/bin/xrdb -merge $HOME/.Xresources

    # xmonad
    ${pkgs.trayer}/bin/trayer \
      --edge top --align right --SetDockType true --SetPartialStrut true \
      --expand true --width 10 --transparent true --tint 0x000000 --height 18 &
    ${pkgs.xorg.xrdb}/bin/xsetroot -cursor_name left_ptr -fg gray -bg black -solid black &
    exec ${pkgs.xmonad-with-packages}/bin/xmonad
  '';
}
