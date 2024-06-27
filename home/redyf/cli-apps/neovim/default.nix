{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      neovim
      stylua
      sumneko-lua-language-server
      ripgrep
    ];
  };
}
