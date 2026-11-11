{
  lib,
  buildGoModule,
  fetchFromGitHub,
  git,
  versionCheckHook,
  nix-update-script,
}:

buildGoModule (finalAttrs: {
  pname = "cymbal";
  version = "0.14.0";

  src = fetchFromGitHub {
    owner = "1broseidon";
    repo = "cymbal";
    tag = "v${finalAttrs.version}";
    hash = "sha256-nJ5Bg3Z+BZKiOCbjkbEd0mjgXLUMOxiYU4+RV3X5fDE=";
  };

  vendorHash = "sha256-b05Mz06EGHKnsK8d35jRT+GxjNsSeKGEA3G//twntk4=";

  # Keep full module contents: tree-sitter bindings reference C sources
  # outside their Go package dir (e.g. ../../typescript/src/parser.c),
  # which `go mod vendor` would strip.
  proxyVendor = true;

  # Required by upstream for FTS5 support in the bundled SQLite
  # (mattn/go-sqlite3), see Makefile and README.
  env.CGO_CFLAGS = "-DSQLITE_ENABLE_FTS5";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/1broseidon/cymbal/cmd.version=${finalAttrs.version}"
  ];

  # Dev-only benchmark tool, not meant to be installed.
  excludedPackages = [ "bench" ];

  # End-to-end tests shell out to git.
  nativeCheckInputs = [ git ];

  doInstallCheck = true;
  nativeInstallCheckInputs = [
    git
    versionCheckHook
  ];
  versionCheckProgramArg = "version";

  # Beyond versionCheckHook: indexing and querying a scratch repo
  # exercises the SQLite/FTS5 cgo path.
  installCheckPhase = ''
    runHook preInstallCheck

    export HOME="$TMPDIR"
    repo="$TMPDIR/cymbal-smoke"
    mkdir -p "$repo"
    cd "$repo"
    git init -q .
    printf 'package main\n\nfunc main() {}\n' > main.go

    "$out/bin/cymbal" index .
    "$out/bin/cymbal" outline main.go | grep -q "main"

    runHook postInstallCheck
  '';

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Fast, language-agnostic code navigator backed by a local SQLite index";
    homepage = "https://github.com/1broseidon/cymbal";
    changelog = "https://github.com/1broseidon/cymbal/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ redyf ];
    mainProgram = "cymbal";
  };
})
