{ config, pkgs, ... }:

let

  myFCConf = pkgs.runCommandLocal "my-fontconfig-conf" {} ''
    mkdir -p $out/etc/fonts
    ln -s ${./src/fontconfig} $out/etc/fonts/conf.d
  '';

in

{
  imports = [
    ./common.nix
  ];

  home.packages = with pkgs; [
    # X11
    haskellPackages.xmobar
    xsel
    pcmanx-gtk2

    # utils
    ranger
    atool
    unzip
    cmus

    # fonts
    myFCConf

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

  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = ./src/xmonad.hs;
  };

  programs.firefox = {
    enable = true;
    profiles.default.settings = {
      "browser.tabs.insertRelatedAfterCurrent" = false;
      "security.certerrors.mitm.auto_enable_enterprise_roots" = false;
    };
  };

  programs.urxvt = {
    enable = true;
    scroll.bar.enable = false;
    iso14755 = false;
    fonts = [
      "xft:Inconsolata:pixelsize=16"
      "xft:AR PL New Sung Mono:pixelsize=16"
      "xft:IPAGothic:pixelsize=16"
      "xft:DejaVu Sans Mono:pixelsize=16"
      "xft:FreeMono:pixelsize=16"
    ];
    extraConfig = {
      "background" = "black";
      "foreground" = "lightgray";
      "color12" = "#6464ff";
    };
  };

  programs.rtorrent = {
    enable = true;
    settings =
      let
        home = config.home.homeDirectory;
        downloadRate = 3000;
        uploadRate = 1000;
        downloadDir = "${home}/download";
        sessionDir = "${home}/tmp/rt-session";
        torrentDir = "${home}/download/torrents";
      in
        ''
          throttle.max_peers.normal.set = 300

          throttle.max_peers.seed.set = 3
          throttle.max_uploads.set = 3

          throttle.global_down.max_rate.set_kb = ${toString downloadRate}
          throttle.global_up.max_rate.set_kb = ${toString uploadRate}

          directory.default.set = ${downloadDir}

          session.path.set = ${sessionDir}

          schedule2 = watch_directory,5,5,load.start=${torrentDir}/*.torrent
          schedule2 = untied_directory,5,5,stop_untied=

          network.port_range.set = 38900-39990
          network.port_random.set = yes

          trackers.use_udp.set = yes

          protocol.encryption.set = allow_incoming,try_outgoing,enable_retry

          dht.mode.set = on
          dht.port.set = 38838

          protocol.pex.set = yes

          ui.torrent_list.layout.set = "full"
        '';
  };

  programs.mpv = {
    enable = true;
    config = {
      profile = "opengl-hq";
      vo = "gpu";
      ao = "alsa";
      hwdec = "vaapi";
      volume-max = "300";
    };
    bindings = {
      UP = "seek 30";
      DOWN = "seek -30";
    };
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

  home.file."bin".source = pkgs.runCommandLocal "home-bin" {} ''
    install -Dm755 ${./src/bin/dmenu_run} $out/dmenu_run
    install -Dm755 ${./src/bin/feh_rifle} $out/feh_rifle
    install -Dm755 ${./src/bin/seq-rename} $out/seq-rename

    substituteInPlace $out/dmenu_run \
      --subst-var-by runtimeShell "${pkgs.runtimeShell}" \
      --subst-var-by util-linux "${pkgs.utillinux}" \
      --subst-var-by dmenu "${pkgs.dmenu}"

    substituteInPlace $out/feh_rifle \
      --subst-var-by ruby "${pkgs.ruby}" \
      --subst-var-by feh "${pkgs.feh}"

    substituteInPlace $out/seq-rename \
      --subst-var-by ruby "${pkgs.ruby}"
  '';

  xdg.configFile."ranger/commands.py".source = pkgs.runCommandLocal "ranger-config-command.py" {} ''
    install -m644 ${./src/ranger/commands.py} $out

    substituteInPlace $out \
      --subst-var-by atool "${pkgs.atool}" \
      --subst-var-by ffmpeg "${pkgs.ffmpeg}" \
      --subst-var-by mplayer "${pkgs.mplayer}"
  '';

  xdg.configFile."ranger/rifle.conf".source = pkgs.runCommandLocal "ranger-config-rifle.conf" {} ''
    install -m644 ${pkgs.ranger}/share/doc/ranger/config/rifle.conf $out

    sed -E -i \
      -e '/^mime[ ]+\^image,[ ]+has[ ]+feh,/ { s/feh( --)?/feh_rifle/g }' \
      $out
  '';
}
