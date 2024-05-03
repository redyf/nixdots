{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      neovim
      lazygit
      stylua
      sumneko-lua-language-server
      ripgrep
    ];
  };
}
