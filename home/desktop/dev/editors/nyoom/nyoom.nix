{
  neovim-unwrapped,
  wrapNeovim,
  fetchFromGitHub,
  stdenv,
  makeWrapper,
  lib,
  ripgrep,
  git,
  fzf,
}: let
  nvim-customized = wrapNeovim neovim-unwrapped {};
in
  stdenv.mkDerivation rec {
    pname = "nyoom-nvim";
    version = "unstable-2023-06-06";

    src = fetchFromGitHub {
      owner = "nyoom-engineering";
      repo = "nyoom.nvim";
      rev = "947afef56a58e3d926e424d2c3d37194d357a40e";
      hash = "sha256-b1kj4LtSe4jixYLSSBbJuDFDk7GuArSU7GjkvQs/DK8=";
    };

    nativeBuildInputs = [makeWrapper nvim-customized];
    buildInputs = [nvim-customized];

    meta = with lib; {
      description = "A Neovim framework and doom emacs alternative for the stubborn martian hacker. Powered by fennel and the oxocarbon theme";
      homepage = "https://github.com/nyoom-engineering/nyoom.nvim.git";
      license = licenses.mit;
      maintainers = with maintainers; [];
    };

    buildPhase = ''
      echo "hello"
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin

      cp -r $(pwd) $out/nyoom

      export shim="$out/nyoom/bin/nyoom"

      substituteInPlace "$shim" \
        --replace "exec nvim" "exec ${nvim-customized}/bin/nvim"

      chmod +x "$shim"

      makeWrapper "$shim" "$out/bin/nyoom" \
        --set NYOOM_RUNTIME_DIR "$out" \
        --prefix PATH : ${lib.makeBinPath [fzf git ripgrep]}
      runHook postInstall
    '';
  }
