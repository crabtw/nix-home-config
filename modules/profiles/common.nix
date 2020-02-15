{ config, pkgs, ... }:

{
  imports = [
    ../services/today-books.nix
  ];

  home.packages = with pkgs; [
    file
    pstree
    tig
    subversion
    fd
    ripgrep
    ruby
    cabal2nix
    weechat
  ];

  home.sessionVariables = {
    PATH = "$HOME/bin:$PATH";
    EDITOR = "vim";
    TERMINFO = pkgs.runCommandLocal "terminfo" {} ''
      ${pkgs.ncurses}/bin/tic -o $out ${./src/terminfo.src}
    '';
  };

  accounts.email.accounts.gmail = {
    primary = true;
    realName = "Jyun-Yan You";
    address = "jyyou.tw@gmail.com";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "ls --color=auto";
      grep = "grep --color=auto";
      less = "less -i";
      rm = "rm -i";
      cp = "cp -i";
      mv = "mv -i";
    };
  };

  programs.git = with config.accounts.email.accounts; {
    enable = true;
    userName = gmail.realName;
    userEmail = gmail.address;
    aliases = {
      pullall = "!git pull && git submodule sync && git submodule update --init --recursive --progress";
    };
  };

  programs.mercurial = with config.accounts.email.accounts; {
    enable = true;
    userName = gmail.realName;
    userEmail = gmail.address;
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    terminal = "screen-256color";
    historyLimit = 10000;
  };

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      my-vim
      rust-vim
      vim-nix
    ];
    extraConfig = ''
      set nocompatible
      set ruler

      set expandtab
      set softtabstop=4
      set shiftwidth=4

      set fileformat=unix
      set fileformats=unix,dos,mac

      set encoding=utf-8
      set fileencoding=utf-8
      set fileencodings=ucs-bom,utf-8,big5,latin1

      set hlsearch
      colorscheme torte

      syntax on
    '';
  };
}