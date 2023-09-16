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
          sha256 = "09w2db0yvxw9byw4dr10wm73vk5y4bcii0nlxzh7f7w3jhy8pbbg";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/newterm/st-newterm-0.9-tmux.diff";
          sha256 = "1kr7raralb71449x9jsmkdibvak3nfwavkmwnl7x0kfzv10mqp3j";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/dynamic-cursor-color/st-dynamic-cursor-color-0.9.diff";
          sha256 = "1hpyk30a5mkj3lplmxhp8j61y3yxmsg8sx5wjfbvcriv43fcdb5a";
        })
      ];
      # Using a local file
      configFile = writeText "config.def.h" (builtins.readFile ./config.h);
    }))
  ];
}
