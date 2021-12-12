{ lib, stdenv, fetchFromGitHub, meson, ninja }:

stdenv.mkDerivation rec {
  pname = "janet";
  version = "1.19.2";

  src = fetchFromGitHub {
    owner = "janet-lang";
    repo = pname;
    rev = "v${version}";
    sha256 = "0waj22rzxmc0yx1yr0pzw9lwp6my5abfpfi6vq932bmli8y9prpd";
  };

  # we don't have /usr/bin/env in the sandbox, so substitute for a proper,
  # absolute path to janet
  postPatch = ''
    substituteInPlace janet.1 \
      --replace /usr/local/lib/janet $out/lib
  '';

  nativeBuildInputs = [ meson ninja ];

  mesonFlags = [ "-Dgit_hash=release" ];

  patches = lib.optionals stdenv.isDarwin ./darwin-remove-net-test.patch;

  doCheck = true;

  meta = with lib; {
    description = "Janet programming language";
    homepage = "https://janet-lang.org/";
    license = licenses.mit;
    maintainers = with maintainers; [ andrewchambers peterhoeg ];
    platforms = platforms.all;
  };
}
