{pkgs, ...}: let
  tshSrc = pkgs.fetchFromGitHub {
    owner = "JohannesNakayama";
    repo = "tsh";
    rev = "main";
    hash = "sha256-iMX88i9RNxLTxhqWiG43cg9X0CPblZ2Fw454eVAqbZE=";
  };
in
  pkgs.rustPlatform.buildRustPackage {
    pname = "tsh";
    version = "0.1.0";
    src = tshSrc;
    cargoLock.lockFile = "${tshSrc}/Cargo.lock";
    installTargets = ["tsh"];
  }
