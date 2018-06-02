{ stdenv, pass, fetchFromGitHub, pythonPackages, makeWrapper }:

let
  zxcvbn = pythonPackages.buildPythonPackage rec {
    pname = "zxcvbn";
    version = "4.4.26";

    src = pythonPackages.fetchPypi {
      inherit pname version;
      sha256 = "1ax9pjpbrva3rprxrcli8crrbspw5s1123wbv2rr461kgq56a8mp";
    };

    meta = {
      homepage = "https://github.com/dwolfhub/zxcvbn-python";
      description = "Python implementation of Dropbox's realistic password strength estimator.";
    };
  };

  pythonEnv = pythonPackages.python.withPackages (p: [ p.requests zxcvbn ]);

in stdenv.mkDerivation rec {
  name = "pass-audit-${version}";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "roddhjav";
    repo = "pass-audit";
    #rev = "v${version}";
    rev = "33db5f1";
    sha256 = "1vp2f2ckpgy491i0pxs8b2msyaszdn53d3lhp2b8y1380p5mzqjw";
    #sha256 = "0v0db8bzpcaa7zqz17syn3c78mgvw4mpg8qg1gh5rmbjsjfxw6sm";
  };

  nativeBuildInputs = [ makeWrapper ];

  buildInputs = [ pythonEnv ];

  # Why doesn't import.nix need this?
  patchPhase = ''
    sed -i -e "s|/usr/lib|$out/lib|" audit.bash
  '';

  dontBuild = true;

  installFlags = [ "PREFIX=$(out)" ];

  postFixup = ''
    wrapProgram $out/lib/password-store/extensions/audit.bash \
      --prefix PATH : "${pythonEnv}/bin" \
      --run "export PREFIX"
  '';

  meta = with stdenv.lib; {
    description = "Pass extension for auditing your password repository.";
    homepage = https://github.com/roddhjav/pass-audit;
    license = licenses.gpl3Plus;
    platforms = platforms.unix;
  };
}
