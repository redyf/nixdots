# AGENTS.md

> Updated: 2026-08-01

## What This Repo Is
- NixOS flake for personal hosts `desktop` and `selene`, plus a safe public `example` host.
- `flake.nix` discovers `hosts/*` as `nixosConfigurations` and builds one `homeConfigurations."<username>@<hostname>"` per host whose `meta.nix` user has a `users/<username>.nix` (`nh home switch` picks `$USER@$HOSTNAME` automatically).
- Host metadata lives in `hosts/<name>/meta.nix` (`username`, `system`, `roles`, optional `keyboard = { layout; variant; }`); `lib/hosts.nix` fills the defaults and both NixOS and Home Manager read the result.
- This is primarily a personal NixOS configuration. Treat public reuse as a secondary goal that should be made safe through explicit example/minimal profiles, not by weakening the personal hosts.

## Source Of Truth
- Trust `flake.nix`, `lib/*.nix`, workflow files, and lockfiles over README prose.
- `lib/mkHost.nix` imports `modules/` (every `.nix` file in it is a module; `lib/modules-in.nix`) and `profiles/nixos/<role>.nix` for every role listed in `meta.nix`. Host `configuration.nix` files only import their generated hardware file. The `example` host intentionally avoids generated hardware config.
- `lib/mkHome.nix` imports `home/` for every user (every directory with a `default.nix` is a module). `users/<name>.nix` holds per-user differences and imports `profiles/home/common.nix` (personal users) or `profiles/home/minimal.nix` (example). `hosts/<hostname>/home.nix` (optional) holds per-machine user settings such as monitor layouts. NixOS and HM modules receive `hostname`, `username`, `homeDirectory`, `keyboard` and `theme` (`theme.nix`) as module arguments.
- `profiles/nixos/` holds roles: `common` (every personal host), `workstation` (graphical), `gaming`, `dev`, `laptop`, `nvidia` (desktop only), and `minimal` (public example). Host files should only override or add host-specific choices (monitors, disks, hardware).
- `myConfig.*` is the NixOS module namespace; `myHomeConfig.*` is the Home Manager namespace. Each module declares its own `enable` option at the path matching its file (`modules/services/tlp.nix` → `myConfig.services.tlp.enable`); there are no category-level `enable` switches, so profiles list the leaves they want.
- `pkgs/<name>/package.nix` holds custom packages. `lib/default.nix` turns them into an overlay (`overlays.default`, applied by `mkHost` and `mkHome`), so modules use `pkgs.<name>`, and into the `packages` flake output.

## Commands
- `nh os switch` is the preferred rebuild command on the desktop host.
- `sudo nixos-rebuild switch --flake '.#desktop'` is the direct rebuild fallback.
- `nix flake check` is the main validation command. It runs treefmt (nixfmt + statix) as a check, evaluates every nixosConfiguration and every `<user>@<host>` homeConfiguration.
- `nix fmt` formats the tree with treefmt (`treefmt.nix`: nixfmt + statix, hardware-configuration.nix excluded).
- `nix develop -c deadnix --no-lambda-pattern-names .` lists dead code; it is not enforced (some unused tmux/ghostty themes are kept on purpose).
- `nix eval .#nixosConfigurations.desktop.config.sops.secrets."users/redyf/password".path` checks the desktop secret path.

## Workflow Notes
- CI in `.github/workflows/flake-check.yml` installs Nix (nix-quick-install-action), caches the store (cache-nix-action) and runs `nix flake check`.
- `system.stateVersion` and `home.stateVersion` are pinned to `25.05`; do not bump casually.
- `allowUnfree = true` and the insecure-package allowlist live only in `lib/nixpkgs-config.nix`, shared by `mkHost` and `mkHome`.
- Keep generated `hardware-configuration.nix` files out of broad refactors.

## Nix-Specific Gotchas
- `treefmt.nix` (and `.statix.toml` for manual statix runs) exclude `hosts/*/hardware-configuration.nix`; keep those generated files out of lint noise.
- `hosts/desktop/secrets.yaml` is managed by `sops-nix`; `hosts/desktop/configuration.nix` expects `myConfig.system.sops.enable = true`; the user comes from `meta.nix`.
- `.sops.yaml` defines creation rules for `hosts/desktop/secrets.yaml` and `hosts/selene/secrets.yaml`. Both hosts take the user password from sops (selene derives its age key from the SSH host key, `keyFile = null`).
- `hosts/desktop/disko.nix` and `hosts/selene/disko.nix` are parameterized with a required `device`; keep destructive disk choices explicit.
- `modules/cli/nh.nix` defaults the flake path to `${homeDirectory}/opensource/nixdots`, but `myConfig.cli.nh.flakePath` can override it.
- `home/cli/tools/git/default.nix` keeps SOPS-rendered identities and work SSH hosts opt-in; enable them from personal user files, not reusable profiles.
- `font-flake` is a local-path flake input (`ci/font-flake-fallback/`) providing proprietary fonts (Monolisa, etc.); the real private font flake is not in this repo.

## Public Reuse / Onboarding
- Prefer `hosts/example` and `users/example.nix` over telling users to install `.#desktop` or `.#selene`.
- A reusable example host should avoid `sops-nix`, private caches, NVIDIA-specific settings, fixed monitor names, fixed disk devices, and personal paths.
- A reusable Home Manager example should avoid `/run/secrets`, personal SSH keys, work identities, local wallpaper paths, and location-specific settings.
- Personal UI settings belong in personal modules or user files. If a module is enabled by a generic profile, it should either work without personal files or expose options for those paths.
- For common-user testing, prefer build-only and VM-friendly flows before real hardware install instructions.

## Architecture Preferences
- Keep module options close to the module that consumes them. Avoid adding broad compatibility layers unless there is a concrete external consumer.
- Derive values from host metadata when possible. Avoid repeating `username`, `homeDirectory`, and similar identity fields in multiple places.
- Use `lib.mkDefault` in shared profiles and concrete assignments in host/user files.
- Personal baseline = roles `common` + `workstation`. If a safer public baseline is needed, use or extend the `minimal` role instead of weakening the personal roles.
- Remove stale option namespaces instead of extending them. Root import files should import modules, not define unused control planes.

## References
- [docs/sops-setup.md](./docs/sops-setup.md) — SOPS/age setup walkthrough.

## Editing Rules
- Keep changes minimal and in the smallest module that owns the setting.
- Do not edit generated `hardware-configuration.nix` unless regenerating hardware config.
- Avoid touching secrets or private keys; `.gitignore` already excludes common age key files and `keys.txt`.
