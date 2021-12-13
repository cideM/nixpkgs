{ lib, stdenv, fetchFromGitHub, meson, ninja, janet }:

stdenv.mkDerivation rec {
  pname = "jpm";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "janet-lang";
    repo = pname;
    rev = version;
    sha256 = "08mznb98h7s0ivjf29bv9jw0iir17si84srv70ac3jfxpm5kc689";
  };

  installPhase = ''
    PREFIX=$out DESTDIR=$out ${janet}/bin/janet $src/bootstrap.janet
  '';

  meta = with lib; {
    description = "JPM is the Janet Project Manager tool";
    homepage = "https://janet-lang.org/docs/jpm.html";
    license = licenses.mit;
    maintainers = with maintainers; [ fbrs ];
    platforms = platforms.all;
  };
}
