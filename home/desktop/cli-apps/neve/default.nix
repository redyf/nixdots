{pkgs, ...}: {
  environment = {
    variables = {
      EDITOR = "nvim";
    };
  };
  home.packages = with pkgs; [
    neve
    lazygit
    stylua
    sumneko-lua-language-server
    ripgrep
  ];
}
