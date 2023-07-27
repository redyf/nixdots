{pkgs, ...}: {
  home.packages = with pkgs; [
    (st.overrideAttrs (oldAttrs: rec {
      buildInputs = oldAttrs.buildInputs ++ [harfbuzz];
      patches = [
        # You can specify local patches
        # ./path/to/local.diff
        # Fetch them directly from `st.suckless.org`
        # (fetchpatch {
        #   url = "https://st.suckless.org/patches/rightclickpaste/st-rightclickpaste-0.8.2.diff";
        #   sha256 = "sha256-dubUsI7HUYdYcawZ7UkP3r8F9mvtTNPeS0VgMFcbpQQ=";
        # })
        (fetchpatch {
          url = "https://st.suckless.org/patches/ligatures/0.9/st-ligatures-20230105-0.9.diff";
          sha256 = "sha256-F2LvUT2bPFfkw82vFS16wwGoB+TEIquTG2UnKAZfzh0=";
        })
        # Or from any other source
        # (fetchpatch {
        #   url = "https://raw.githubusercontent.com/fooUser/barRepo/1111111/somepatch.diff";
        #   sha256 = "222222222222222222222222222222222222222222";
        # })
      ];
    }))
  ];
}
