{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    nvim.enable = lib.mkEnableOption "Enable neovim module";
  };
  config = lib.mkIf config.nvim.enable {
    home = {
      packages = with pkgs; [
        neovim
        pkgs.vimPlugins.nvim-treesitter.withAllGrammars
        # (vimPlugins.nvim-treesitter.withPlugins (
        #   p: with p; [
        #     tree-sitter-query # Prioridade máxima
        #     tree-sitter-r # Para o arquivo que você compartilhou
        #     tree-sitter-rust # Para o arquivo que você compartilhou
        #     tree-sitter-nix # Para editar arquivos Nix
        #     tree-sitter-lua # Para configurações do Neovim
        #     tree-sitter-python # Opcional, mas útil
        #     tree-sitter-c # Opcional
        #     tree-sitter-cpp # Opcional
        #   ]
        # ))
      ];
    };
  };
}
