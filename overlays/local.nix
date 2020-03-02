self: super:

let

  pkgs = super.pkgs;

  lib = super.lib;

in

{
  haskellPackages = super.haskellPackages.override {
    overrides = self: super: import ../pkgs/haskell-packages.nix {
      pkgs = pkgs;
      stdenv = pkgs.stdenv;
      callPackage = self.callPackage;
    };
  };

  vimPlugins = super.vimPlugins // (
    let
      inherit (super) vim;
      inherit (super.vimUtils.override {inherit vim;}) buildVimPluginFrom2Nix;
    in
      {
        my-vim = super.callPackage ../pkgs/my-vim-plugin.nix {
          inherit buildVimPluginFrom2Nix;
        };
      }
  );

  vmware-horizon-client = super.callPackage ../pkgs/vmware-horizon-client.nix {};
}
