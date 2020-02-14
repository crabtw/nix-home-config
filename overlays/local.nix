self: super:

{
  haskellPackages = super.haskellPackages.override {
    overrides =
      let
        inherit (super) fetchFromGitHub;
      in
        self: super: {
          wawabook = self.callPackage ../pkgs/wawabook.nix {};
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

  wqy_unibit = super.callPackage ../pkgs/wqy-unibit.nix {};

  opendesktop-fonts = super.callPackage ../pkgs/opendesktop-fonts.nix {};
}
