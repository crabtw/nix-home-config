self: super:

{
  haskellPackages = super.haskellPackages.override {
    overrides =
      let
        fetchFromGitHub = super.fetchFromGitHub;
      in
        self: super: {
          wawabook = self.callPackage ../pkgs/wawabook.nix {
            inherit fetchFromGitHub;
          };
        };
  };

  wqy_unibit = super.callPackage ../pkgs/wqy-unibit.nix {};

  opendesktop-fonts = super.callPackage ../pkgs/opendesktop-fonts.nix {};
}
