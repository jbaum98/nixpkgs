{ stdenv, lib, fetchFromGitea, meson, ninja, pkg-config, vala, gettext, gtk4, libadwaita, libgee, vul-vala, blueprint-compiler, desktop-file-utils, wrapGAppsHook4 }:
let 
  pname = "fruit-credits";
  version = "0.1.1";
in stdenv.mkDerivation {
  inherit pname version;

  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "dz4k";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-c5XTeF+ihSX0f49zCNUuCIaX49+ZFIPkFEskJqJ54PM=";
  };

  nativeBuildInputs = [ meson ninja vala gettext pkg-config blueprint-compiler desktop-file-utils wrapGAppsHook4 ];

  buildInputs = [ gtk4 libadwaita libgee vul-vala ];
}
