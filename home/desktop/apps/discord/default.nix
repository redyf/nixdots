{pkgs, ...}: {
  home.packages = [
    (pkgs.discord.override {
      withOpenASAR = false;
      withVencord = true;
    })
  ];
}
