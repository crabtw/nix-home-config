### Installation

```console
$ nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
$ nix-channel --update
```

Re-login to make channel available

```console
$ mkdir -p ~/.config
$ ln -s $(pwd) ~/.config/nixpkgs
$ nix-shell '<home-manager>' -A install
```

Add imports to `home.nix`

```nix
{
  imports = [
    ./roles/server.nix
  ]; 
}
```

Generate dotfiles

```
$ home-manager switch
```
