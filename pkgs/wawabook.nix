{ mkDerivation, base, bytestring, conduit, http-conduit, resourcet
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
}
