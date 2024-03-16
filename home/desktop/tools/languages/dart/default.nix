{pkgs, ...}: {
  home.packages = with pkgs; [
    flutter
    android-studio
  ];

  # Sets up all the libraries to load for the flutter build, otherwise the emulators won't work
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    fuse3
    icu
    zlib
    nss
    openssl
    curl
    expat
    clang
    cmake
    libGL
    nspr
    libuuid
    libxkbcommon
    libxml2
    mesa
    vulkan-loader
    libpulseaudio
    alsa-lib
    xorg.libX11
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXcomposite
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    xorg.libxcb
    xorg.libxkbfile
    xorg.libxshmfence
  ];
}
