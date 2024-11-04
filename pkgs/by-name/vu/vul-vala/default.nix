{ stdenv, lib, fetchFromGitLab, meson, ninja, pkg-config, vala, gettext, gobject-introspection, libgee, glib, libarchive }:
let 
  pname = "vul";
in stdenv.mkDerivation {
  inherit pname;
  version = "d17c04b2";

  src = fetchFromGitLab {
    domain = "gitlab.gnome.org";
    owner = "BZHDeveloper";
    repo = pname;
    rev = "d17c04b292ba6d971f920b0413aabb25c1ce30ae";
    hash = "sha256-UIE0tYs5H0x5yX6Dhc3VSNAvNVUmmlQz1a0TMWoJLa4=";
  };

  nativeBuildInputs = [ meson vala gettext pkg-config gobject-introspection ninja ];

  buildInputs = [ libgee glib libarchive ];
}
