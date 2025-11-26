{
  stdenv,
  pkgs,
}:
with pkgs; let
  version = "1.0.1";
  pname = "trackpad-is-too-damn-big";
in
  stdenv.mkDerivation {
    inherit version;
    inherit pname;

    src = fetchFromGitHub {
      owner = "luqmanishere";
      repo = "${pname}";
      rev = "b4397dcf8134b5f1d50e81c65fbade1de7540001";
      sha256 = "VK9rbtX8Ww0dvbGo4qB+3VR6lLd5OTBwDUZwa7AShHo=";
      fetchSubmodules = true;
    };
    nativeBuildInputs = [
      clang
      cmake
      pkg-config
    ];
    buildInputs = [libevdev];
    buildPhase = "make -j $NIX_BUILD_CORES";
    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin
      mv $TMP/source/build/titdb $out/bin
      runHook postInstall
    '';

    meta = with lib; {
      description = "A customizable utility that allows Linux users to change trackpad behaviour";
      license = licenses.gpl3Only;
      platforms = platforms.linux;
      mainProgram = "titdb";
    };
  }
