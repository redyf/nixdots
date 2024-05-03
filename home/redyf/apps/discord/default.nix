{pkgs, ...}: {
  home.packages = with pkgs; [
    vesktop
    # (discord.override {
    #   withOpenASAR = false;
    #   withVencord = true;
    # })
  ];
}
