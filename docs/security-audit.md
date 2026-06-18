# Security Audit: nixdots

> Audit performed on 2026-05-14. Public repository on GitHub.

---

## Summary

The repository has a solid security baseline: firewall enabled, `sops-nix` configured for the desktop host, and no committed private keys found. Five issues were fixed; the remaining items below require either manual action or an explicit decision.

---

## Pending Items / Conscious Decisions

### Selene Host Password

- **File:** `hosts/selene/configuration.nix`
- **Status:** `initialPassword = "123456"` was removed. The `selene` user currently has no password configured, so password login is disabled.
- **Action:** Configure `sops-nix` for `selene` like the desktop host and use `hashedPasswordFile`, or set the password manually with `passwd selene` from a TTY after rebuilding.

### Git History

`initialPassword = "123456"` still exists in old public commits. In this repo, that value was installation boilerplate and was manually changed after applying the configuration, so there is no indication that a real password leaked.

If that value was ever used as a real password on an accessible machine, treat it as compromised and rotate it.

```bash
nix-shell -p git-filter-repo
```

> Rewriting public Git history requires a force push and breaks old clones. Only do this if there is a real need to remove the boilerplate from history.

---

## Fixed

| Item | File | Change |
|---|---|---|
| Root SSH login | `modules/system/ssh.nix:15` | `PermitRootLogin "yes"` to `"no"` |
| Weak plaintext password | `hosts/selene/configuration.nix:21` | Removed `initialPassword = "123456"` |
| Nginx on all interfaces | `modules/development/nginx.nix:17` | `0.0.0.0` to `127.0.0.1` |
| Exposed K3s API server | `modules/development/k3s.nix` | Added `--bind-address=127.0.0.1` |
| Plaintext Git identity | `home/cli/tools/git/default.nix` | Made SOPS-rendered identity and work SSH hosts opt-in |

---

## What Looks Good

- Firewall is enabled with `networking.firewall.enable = true`.
- IPv6 is disabled, reducing exposed network surface.
- `sops-nix` is correctly configured for the desktop host.
- The SOPS usage guide is documented in `docs/sops-setup.md`.
- No committed private SSH keys were found.
- No plaintext tokens or API keys were found.
- `.gitignore` protects `age-key*.txt`, `*.age`, `keys.txt`, and related key files.
- The age public key in `.sops.yaml` is safe to commit by design.
