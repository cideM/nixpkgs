{
  lib,
  fetchFromGitHub,
  rustPlatform,
  stdenv,
  Security,
  libiconv,
}:

rustPlatform.buildRustPackage rec {
  version = "0.35.0";
  pname = "geckodriver";

  src = fetchFromGitHub {
    owner = "mozilla";
    repo = "geckodriver";
    tag = "v${version}";
    sha256 = "sha256-3EJP+y+Egz0kj5e+1FRHPGWfneB/tCCVggmgmylMyDE=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-BZosk8tCHpQqQTNFe8BPArdkTHoRN/SViG10xtYs8jY=";

  buildInputs = lib.optionals stdenv.hostPlatform.isDarwin [
    libiconv
    Security
  ];

  meta = with lib; {
    description = "Proxy for using W3C WebDriver-compatible clients to interact with Gecko-based browsers";
    homepage = "https://github.com/mozilla/geckodriver";
    license = licenses.mpl20;
    maintainers = with maintainers; [ jraygauthier ];
    mainProgram = "geckodriver";
  };
}
