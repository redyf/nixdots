final: prev: {
  opencode = prev.opencode.overrideAttrs (old: {
    doInstallCheck = false;
  });
}
