{ mkDerivation, aeson, base, bytestring, cassava, concurrent-output
, containers, directory, extra, file-embed, filepath, gitlib
, gitlib-libgit2, scientific, shake, split, stdenv, tagged, text
, transformers, unordered-containers, vector, yaml
, fetchFromGitHub, makeWrapper, makeBinPath, allPkgs,
}:

mkDerivation {
  pname = "gipeda";
  version = "0.3.3.2";
  src = fetchFromGitHub {
    owner = "crabtw";
    repo = "gipeda";
    rev = "bf4e723de8f7ca0c5897232c14734aa3da071c1b";
    sha256 = "0x6xz9bjrwrpk3s2xr147ysgw2bk9lj2fqimzf32xaz1vs782rpj";
  };
  buildTools = [ makeWrapper ];
  postPatch = ''
    substituteInPlace ./install-jslibs.sh \
      --replace /bin/bash "${allPkgs.runtimeShell}"
  '';
  postInstall =
    let path = with allPkgs; makeBinPath [ coreutils wget unzip git ]; in ''
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
}
