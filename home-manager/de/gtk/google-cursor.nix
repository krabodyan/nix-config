{ stdenv, fetchFromGitHub, nodejs_20, clickgen, yarn, }:
stdenv.mkDerivation {
  name = "google-cursor";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "ful1e5";
    repo = "Google_Cursor";
    rev = "7e416f8ae074a9346bf860961a0c4d47a58f4f00";
    sha256 = "sha256-ON4dwn24sc+8gSErelBsCQo4PLb7Vy6/x7JfXyuvg+4=";
  };

  buildInputs = [ nodejs_20 clickgen yarn ];
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons

    yarn build
    npx cbmp -d 'svg' -n 'GoogleDot' -bc '#575757' -oc '#a3a3a3'
    ctgen build.toml -s 18 -d 'bitmaps/GoogleDot' -n 'GoogleDot'

    cp -R GoogleDot $out/share/icons/
    cp -R GoogleDot $out/share/icons/

    runHook postInstall
  '';
}
