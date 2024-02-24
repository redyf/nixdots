{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      neovim # neovim-nightly
      lazygit
      stylua
      sumneko-lua-language-server
      ripgrep
    ];
  };
}
