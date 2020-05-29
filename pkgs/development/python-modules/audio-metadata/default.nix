{ lib, buildPythonPackage, fetchPypi, pythonOlder
, attrs
, bidict
, bitstruct
, more-itertools
, pprintpp
, tbm-utils
}:

buildPythonPackage rec {
  pname = "audio-metadata";
  version = "0.10.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1hhm1kv1p2x8vxx5rmbsfra42fr2z38yz0giw7rkrfziy70xzpy8";
  };

  postPatch = ''
    substituteInPlace setup.py \
      --replace 'pendulum>=2.0,<=3.0,!=2.0.5,!=2.1.0' 'pendulum'
  '';

  propagatedBuildInputs = [
    attrs
    bidict
    bitstruct
    more-itertools
    pprintpp
    tbm-utils
  ];

  # No tests
  doCheck = false;

  disabled = pythonOlder "3.6";

  meta = with lib; {
    homepage = "https://github.com/thebigmunch/audio-metadata";
    description = "A library for reading and, in the future, writing metadata from audio files";
    license = licenses.mit;
    maintainers = with maintainers; [ jakewaksbaum ];
  };
}
