{ pkgs, stdenv, callPackage }:

{
  "wawabook" = callPackage
    ({ mkDerivation, base, bytestring, conduit, http-conduit, resourcet
     , stdenv, tagsoup, time, transformers
     , fetchFromGitHub
     }:
     mkDerivation {
       pname = "wawabook";
       version = "0.1.0.0";
       src = fetchFromGitHub {
         owner = "crabtw";
         repo = "wawabook";
         rev = "f11823e50d6174ca1e450bc7a76b249c06d1362f";
         sha256 = "1rggi3amyrbnyilaflsq0zs7w4q36ganpzyh6sjqh1gqsaik5yvv";
       };
       isLibrary = false;
       isExecutable = true;
       executableHaskellDepends = [
         base bytestring conduit http-conduit resourcet tagsoup time
         transformers
       ];
       description = "A HTML scraper for wawabook.com.tw";
       license = stdenv.lib.licenses.asl20;
     }) {};

  "gipeda" = callPackage
    ({ mkDerivation, aeson, base, bytestring, cassava, concurrent-output
     , containers, directory, extra, file-embed, filepath, gitlib
     , gitlib-libgit2, scientific, shake, split, stdenv, tagged, text
     , transformers, unordered-containers, vector, yaml
     , fetchFromGitHub, makeWrapper, makeBinPath
     , runtimeShell, coreutilsBin, wgetBin, unzipBin, gitBin
     }:
     mkDerivation {
       pname = "gipeda";
       version = "0.3.3.2";
       src = fetchFromGitHub {
         owner = "crabtw";
         repo = "gipeda";
         rev = "b0d902ec1cea7a983e3038731b0516300adeec7f";
         sha256 = "1986g5pghhhs4rwmc5ylcibiia9yqhpzs42n2qhg9y0dd6rkmbqj";
       };
       buildTools = [ makeWrapper ];
       postPatch = ''
         substituteInPlace ./install-jslibs.sh \
           --replace /bin/bash "${runtimeShell}"
       '';
       postInstall =
         let path = makeBinPath [ coreutilsBin wgetBin unzipBin gitBin ]; in ''
         wrapProgram $out/bin/gipeda \
           --prefix PATH : "${path}"
       '';
       isLibrary = false;
       isExecutable = true;
       executableHaskellDepends = [
         aeson base bytestring cassava concurrent-output containers
         directory extra file-embed filepath gitlib gitlib-libgit2
         scientific shake split tagged text transformers
         unordered-containers vector yaml
       ];
       homepage = "https://github.com/nomeata/gipeda";
       description = "Git Performance Dashboard";
       license = stdenv.lib.licenses.mit;
     }) {
       inherit (pkgs.lib) makeBinPath;
       inherit (pkgs) runtimeShell;
       coreutilsBin = pkgs.coreutils;
       wgetBin = pkgs.wget;
       unzipBin = pkgs.unzip;
       gitBin = pkgs.git;
     };

  "gitlib" = callPackage
    ({ mkDerivation, base, base16-bytestring, bytestring, conduit
     , conduit-combinators, containers, directory, exceptions, filepath
     , hashable, mtl, resourcet, semigroups, tagged, text, time
     , transformers, unix, unliftio, unliftio-core, unordered-containers
     }:
     mkDerivation {
       pname = "gitlib";
       version = "3.1.2";
       sha256 = "1r973cpkp4h8dfjrkqgyy31a3x4bbqi7zhpck09ix2a9i597b345";
       revision = "1";
       editedCabalFile = "09v2acn2cxagyfnn7914faz9nzzi2j48w8v55lj1fxwgspc44w8g";
       postPatch = ''
         substituteInPlace ./Git/Types.hs \
           --replace "textToSha :: Monad" "textToSha :: MonadFail"
       '';
       libraryHaskellDepends = [
         base base16-bytestring bytestring conduit conduit-combinators
         containers directory exceptions filepath hashable mtl resourcet
         semigroups tagged text time transformers unix unliftio
         unliftio-core unordered-containers
       ];
       description = "API library for working with Git repositories";
       license = stdenv.lib.licenses.mit;
       hydraPlatforms = stdenv.lib.platforms.none;
     }) {};

  "gitlib-libgit2" = callPackage
    ({ mkDerivation, base, bytestring, conduit, conduit-combinators
     , containers, directory, exceptions, fast-logger, filepath, gitlib
     , gitlib-test, hlibgit2, hspec, hspec-expectations, HUnit, mmorph
     , monad-loops, mtl, resourcet, stm, stm-conduit, tagged
     , template-haskell, text, text-icu, time, transformers
     , transformers-base, unliftio, unliftio-core
     }:
     mkDerivation {
       pname = "gitlib-libgit2";
       version = "3.1.2.1";
       sha256 = "0gm2d8x7brcf3x3d6jy3anig158cj3961gicw1wq7xg0wz90l3mr";
       libraryHaskellDepends = [
         base bytestring conduit conduit-combinators containers directory
         exceptions fast-logger filepath gitlib hlibgit2 mmorph monad-loops
         mtl resourcet stm stm-conduit tagged template-haskell text text-icu
         time transformers transformers-base unliftio unliftio-core
       ];
       testHaskellDepends = [
         base exceptions gitlib gitlib-test hspec hspec-expectations HUnit
         transformers
       ];
       description = "Libgit2 backend for gitlib";
       license = stdenv.lib.licenses.mit;
       hydraPlatforms = stdenv.lib.platforms.none;
     }) {};

  "gitlib-test" = callPackage
    ({ mkDerivation, base, bytestring, conduit, conduit-combinators
     , exceptions, gitlib, hspec, hspec-expectations, HUnit, tagged
     , text, time, transformers, unliftio-core
     }:
     mkDerivation {
       pname = "gitlib-test";
       version = "3.1.2";
       sha256 = "17v84igqyhc808nzv2qsyylk9ls4kzfd9hdx1avj4vb4gc5gblzz";
       libraryHaskellDepends = [
         base bytestring conduit conduit-combinators exceptions gitlib hspec
         hspec-expectations HUnit tagged text time transformers
         unliftio-core
       ];
       description = "Test library for confirming gitlib backend compliance";
       license = stdenv.lib.licenses.mit;
       hydraPlatforms = stdenv.lib.platforms.none;
     }) {};
}
