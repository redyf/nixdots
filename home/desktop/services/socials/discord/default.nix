{ pkgs, ... }: {
  home.packages = with pkgs; [
    (discord.override {
      # remove any overrides that you don't want
      withOpenASAR = false;
      withVencord = true;
    })
  ];
}
