{pkgs, ...}: {
  home.packages = with pkgs; [
    (st.overrideAttrs (oldAttrs: rec {
      buildInputs = oldAttrs.buildInputs ++ [harfbuzz];
      patches = [
        (fetchpatch {
          url = "https://st.suckless.org/patches/ligatures/0.9/st-ligatures-20230105-0.9.diff";
          sha256 = "sha256-F2LvUT2bPFfkw82vFS16wwGoB+TEIquTG2UnKAZfzh0=";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/newterm/st-newterm-0.9.diff";
          sha256 = "sha256-U4UhvROueU3S45lN3F8BdQ/mABhxJYM923mVaQCol+Y=";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/newterm/st-newterm-0.9-tmux.diff";
          sha256 = "sha256-YFX8lpgZa659xSgnFmHmn9wKJtIwIk8cLKsH7DH4Vwc=";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/dynamic-cursor-color/st-dynamic-cursor-color-0.9.diff";
          sha256 = "sha256-JugrLvbnacZ6SfVl+V6tLM30LEKWBnRi6WM9oJR9OAA=";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/font2/st-font2-0.8.5.diff";
          sha256 = "sha256-tSMk5c5Hz6/dv3tcyh+0R91Vy1jgU52Y1sjqy2o08x4=";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/w3m/st-w3m-0.8.3.diff";
          sha256 = "sha256-nVSG8zuRt3oKQCndzm+3ykuRB1NMYyas0Ne3qCG59ok=";
        })
      ];
      # Using a local file
      configFile = writeText "config.def.h" (builtins.readFile ./config.h);
      postPatch = oldAttrs.postPatch + "cp ${configFile} config.def.h";
    }))
  ];
}
