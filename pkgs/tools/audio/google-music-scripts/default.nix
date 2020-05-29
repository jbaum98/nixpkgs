{ lib, python3 }:

with python3.pkgs;

buildPythonApplication rec {
  pname = "google-music-scripts";
  version = "4.5.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0apwgj86whrc077dfymvyb4qwj19bawyrx49g4kg364895v0rbbq";
  };

  postPatch = ''
    substituteInPlace setup.py \
      --replace 'loguru>=0.4.0,<0.5.0' 'loguru' \
      --replace 'pendulum>=2.0,<=3.0,!=2.0.5,!=2.1.0' 'pendulum'
  '';

  propagatedBuildInputs = [
    appdirs
    audio-metadata
    google-music
    google-music-proto
    google-music-utils
    loguru
    pendulum
    natsort
    tomlkit
  ];

  # No tests
  checkPhase = ''
    $out/bin/gms --help >/dev/null
  '';

  meta = with lib; {
    homepage = "https://github.com/thebigmunch/google-music-scripts";
    description = "A CLI utility for interacting with Google Music";
    license = licenses.mit;
    maintainers = with maintainers; [ jakewaksbaum ];
  };
}
