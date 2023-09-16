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
          url = "https://st.suckless.org/patches/scrollback/st-scrollback-0.8.5.diff";
          sha256 = "sha256-ZZAbrWyIaYRtw+nqvXKw8eXRWf0beGNJgoupRKsr2lc=";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/clipboard/st-clipboard-0.8.3.diff";
          sha256 = "sha256-y7N2dem0mGg2wZqtrMYWoAbfgcm/OU6eNXPhZPoYZ88=";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/alpha/st-alpha-20220206-0.8.5.diff";
          sha256 = "sha256-01/KBNbBKcFcfbcpMnev/LCzHpON3selAYNo8NUPbF4=";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/boxdraw/st-boxdraw_v2-0.8.5.diff";
          sha256 = "sha256-WN/R6dPuw1eviHOvVVBw2VBSMDtfi1LCkXyX36EJKi4=";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/font2/st-font2-0.8.5.diff";
          sha256 = "sha256-tSMk5c5Hz6/dv3tcyh+0R91Vy1jgU52Y1sjqy2o08x4=";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/rightclickpaste/st-rightclickpaste-0.8.2.diff";
          sha256 = "sha256-dubUsI7HUYdYcawZ7UkP3r8F9mvtTNPeS0VgMFcbpQQ=";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/desktopentry/st-desktopentry-0.8.4.diff";
          sha256 = "sha256-Hj2YgKHXhRplT8ojGCktygwKPdvaY9l2pteLunz1EGw=";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/newterm/st-newterm-0.8.2.diff";
          sha256 = "sha256-mDAcNLYcmwE27rYW9rxNDGve58VK7itigV/GYZSyxeg=";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/anygeometry/st-anygeometry-0.8.1.diff";
          sha256 = "sha256-mxxRKzkKg7dIQBYq5qYLwlf77XNN4waazr4EnC1pwNE=";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/xresources/st-xresources-20200604-9ba7ecf.diff";
          sha256 = "sha256-8HV66XrTJu80H0Mwws5QL7BV6L9omUH6avFJqdDC7as=";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/anygeometry/st-anygeometry-0.8.1.diff";
          sha256 = "sha256-mxxRKzkKg7dIQBYq5qYLwlf77XNN4waazr4EnC1pwNE=";
        })
        (fetchpatch {
          url = "https://st.suckless.org/patches/sync/st-appsync-20200618-b27a383.diff";
          sha256 = "sha256-lys7/nup7a+GcmW+CutX0kjmbbOis2stkuhw02beuPs=";
        })
      ];
    }))
  ];
}
