{ lib, buildPythonPackage, fetchPypi, isPy27}:

buildPythonPackage rec {
  pname = "glob2";
  version = "0.6";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1miyz0pjyji4gqrzl04xsxcylk3h2v9fvi7hsg221y11zy3adc7m";
  };

  checkPhase = ''
    python test.py
  '';

  meta = with lib; {
    homepage = https://github.com/miracle2k/python-glob2;
    description = "Version of the glob module that supports recursion via **, and can capture patterns";
    license = licenses.free;
    maintainers = with maintainers; [ jakewaksbaum ];
  };
}
