{ lib, fetchurl, stdenv, gettext, pkg-config, glib, gtk2, libX11, libSM, libICE, which
, IOKit ? null }:

with lib;

stdenv.mkDerivation rec {
  name = "gkrellm-2.3.11";

  src = fetchurl {
    url = "http://gkrellm.srcbox.net/releases/${name}.tar.bz2";
    sha256 = "01lccz4fga40isv09j8rjgr0qy10rff9vj042n6gi6gdv4z69q0y";
  };

  nativeBuildInputs = [ pkg-config which ];
  buildInputs = [gettext glib gtk2 libX11 libSM libICE]
    ++ optionals stdenv.isDarwin [ IOKit ];

  hardeningDisable = [ "format" ];

  # Makefiles are patched to fix references to `/usr/X11R6' and to add
  # `-lX11' to make sure libX11's store path is in the RPATH.
  patchPhase = ''
    echo "patching makefiles..."
    for i in Makefile src/Makefile server/Makefile
    do
      sed -i "$i" -e "s|/usr/X11R6|${libX11.dev}|g ; s|-lICE|-lX11 -lICE|g"
    done
  '';

  makeFlags = [ "STRIP=-s" ];
  installFlags = [ "DESTDIR=$(out)" ];

  meta = {
    description = "Themeable process stack of system monitors";
    longDescription = ''
      GKrellM is a single process stack of system monitors which
      supports applying themes to match its appearance to your window
      manager, Gtk, or any other theme.
    '';

    homepage = "http://gkrellm.srcbox.net";
    license = licenses.gpl3Plus;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}
