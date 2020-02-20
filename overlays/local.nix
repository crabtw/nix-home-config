self: super:

let

  pkgs = super.pkgs;

  lib = super.lib;

in

{
  haskellPackages = super.haskellPackages.override {
    overrides = self: super: {
      wawabook = self.callPackage ../pkgs/wawabook.nix {};

      gipeda = self.callPackage ../pkgs/gipeda.nix {
        makeBinPath = lib.makeBinPath;
        allPkgs = pkgs;
      };
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
}
