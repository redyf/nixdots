# AGENTS.md

## What This Repo Is
- NixOS flake for personal hosts `desktop` and `selene`, plus a safe public `example` host.
- `flake.nix` discovers `hosts/*` as `nixosConfigurations` and `home/users/*.nix` as `homeConfigurations`.
- Host metadata lives in `hosts/<name>/meta.nix` (`username`, `system`); home metadata can live in `home/users/<name>.meta.nix`.
- This is primarily a personal NixOS configuration. Treat public reuse as a secondary goal that should be made safe through explicit example/minimal profiles, not by weakening the personal hosts.

## Source Of Truth
- Trust `flake.nix`, `lib/*.nix`, workflow files, and lockfiles over README prose.
- Personal `hosts/<name>/configuration.nix` files import `../../modules` plus generated host hardware files. The `example` host intentionally avoids generated hardware config.
- `home/users/<name>.nix` imports `../apps`, `../cli`, `../desktop`, `../shells`, `../system`.
- `profiles/nixos/base.nix` owns shared NixOS defaults. Host files should only override or add host-specific choices.
- `myConfig.*` is the NixOS module namespace; `myHomeConfig.*` is the Home Manager namespace.

## Commands
- `nh os switch` is the preferred rebuild command on the desktop host.
- `sudo nixos-rebuild switch --flake '.#desktop'` is the direct rebuild fallback.
- `nix flake check` is the main validation command.
- `nix develop -c nixfmt --check <files>` checks formatting; CI runs this before linting.
- `nix develop -c statix check --config ./.statix.toml .` runs linting in CI order.
- `nix eval .#nixosConfigurations.desktop.config.sops.secrets."users/redyf/password".path` checks the desktop secret path.

## Workflow Notes
- CI in `.github/workflows/flake-check.yml` runs `nixfmt --check`, then `statix check`, then `nix flake check`.
- `system.stateVersion` and `home.stateVersion` are pinned to `25.05`; do not bump casually.
- `allowUnfree = true` is enabled in flake, host, and home config paths.
- Keep generated `hardware-configuration.nix` files out of broad refactors.

## Nix-Specific Gotchas
- `.statix.toml` ignores `hosts/*/hardware-configuration.nix`; keep those generated files out of lint noise.
- `hosts/desktop/secrets.yaml` is managed by `sops-nix`; `hosts/desktop/configuration.nix` expects `myConfig.system.sops.enable = true` and `myConfig.users.username = "redyf"`.
- `.sops.yaml` currently only defines a creation rule for `hosts/desktop/secrets.yaml`.
- `hosts/selene/configuration.nix` does not use `sops-nix` for the user password yet.
- `hosts/desktop/disko.nix` and `hosts/selene/disko.nix` are parameterized with a required `device`; keep destructive disk choices explicit.
- `modules/cli/nh.nix` defaults the flake path to `${homeDirectory}/opensource/nixdots`, but `myConfig.cli.nh.flakePath` can override it.
- `home/cli/tools/git/default.nix` keeps SOPS-rendered identities and work SSH hosts opt-in; enable them from personal user files, not reusable profiles.

## Public Reuse / Onboarding
- Prefer `hosts/example` and `home/users/example.nix` over telling users to install `.#desktop` or `.#selene`.
- A reusable example host should avoid `sops-nix`, private caches, NVIDIA-specific settings, fixed monitor names, fixed disk devices, and personal paths.
- A reusable Home Manager example should avoid `/run/secrets`, personal SSH keys, work identities, local wallpaper paths, and location-specific settings.
- Personal UI settings belong in personal modules or user files. If a module is enabled by a generic profile, it should either work without personal files or expose options for those paths.
- For common-user testing, prefer build-only and VM-friendly flows before real hardware install instructions.

## Architecture Preferences
- Keep module options close to the module that consumes them. Avoid adding broad compatibility layers unless there is a concrete external consumer.
- Derive values from host metadata when possible. Avoid repeating `username`, `homeDirectory`, and similar identity fields in multiple places.
- Use `lib.mkDefault` in shared profiles and concrete assignments in host/user files.
- Keep `profiles/nixos/base.nix` as the personal default baseline. If a safer public baseline is needed, add a separate minimal profile instead of weakening `base.nix`.
- Remove stale option namespaces instead of extending them. Root import files should import modules, not define unused control planes.

## Editing Rules
- Keep changes minimal and in the smallest module that owns the setting.
- Do not edit generated `hardware-configuration.nix` unless regenerating hardware config.
- Avoid touching secrets or private keys; `.gitignore` already excludes common age key files and `keys.txt`.
