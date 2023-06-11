{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc # GNU Compiler Collection
    jdk8 # Java dev kit
    beautysh # Shell formatter
    gnupatch
  ];
}
