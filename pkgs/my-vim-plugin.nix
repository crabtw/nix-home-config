{ buildVimPluginFrom2Nix, fetchFromGitHub }:

buildVimPluginFrom2Nix {
  pname = "my-vim";
  version = "2019-11-01";
  src = fetchFromGitHub {
    owner = "crabtw";
    repo = "my.vim";
    rev = "35ec86c446280aff54fb434949f5b17ececb8a40";
    sha256 = "1b1as5faf2krmpkrqgvrcrlbxcp321kzrsvr2y1mwq5a1d2kih00";
  };
}
