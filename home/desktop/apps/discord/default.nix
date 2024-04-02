{pkgs, ...}: {
  home.packages = with pkgs; [
    (discord.override {
      withOpenASAR = false;
      withVencord = true;
    })
  ];
}
