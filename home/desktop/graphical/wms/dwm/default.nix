{pkgs, ...}: {
services.xserver.windowManager.dwm.package = pkgs.dwm.override {
  patches = [
    (pkgs.fetchpatch {
      url = "https://dwm.suckless.org/patches/path/to/patch.diff";
      # replace hash with the value from `nix-prefetch-url "https://dwm.suckless.org/patches/path/to/patch.diff" | xargs nix hash to-sri --type sha256`
      # or just leave it blank, rebuild, and use the hash value from the error
      hash = "";
    })
  ];
};
}
